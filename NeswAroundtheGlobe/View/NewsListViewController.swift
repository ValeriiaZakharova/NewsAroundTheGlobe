//
//  NewsListViewController.swift
//  NeswAroundtheGlobe
//
//  Created by Valeriia Zakharova on 13.10.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    private var news: [NewsModel] = []
    
    private let countryCategoryPicker = UIPickerView()
    
    private let generalCategoryPicker = UIPickerView()
    
    private let countryCategory = CountryCategory.allCases
    
    private let generalCategory = GeneralCategory.allCases
    
    private var selectedCountryCategory: CountryCategory?
    
    private var selectedGeneralCategory: GeneralCategory?
    
    private let networkProvider = NetworkProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        setupCountryCategoryPicker()
        setupGeneralCategoryPicker()
        countryTextField.delegate = self
        categoryTextField.delegate = self
        countryTextField.tintColor = UIColor.clear
        categoryTextField.tintColor = UIColor.clear
        
        getNews()
    }
    
    @objc
    func countryCategoryDoneTapped() {
        let row = countryCategoryPicker.selectedRow(inComponent: 0)
        selectedCountryCategory = countryCategory[row]
        countryTextField.text = selectedCountryCategory?.title
        textFieldShouldReturn(countryTextField)
        getNews()
    }
    
    @objc
    func categoryGeneralDoneTapped() {
        let row = generalCategoryPicker.selectedRow(inComponent: 0)
        selectedGeneralCategory = generalCategory[row]
        categoryTextField.text = selectedGeneralCategory?.title
        textFieldShouldReturn(categoryTextField)
        getNews()
    }
    
    //MARK: - Private
    
    private func getNews() {
        networkProvider.fetchNews(country: selectedCountryCategory?.requestParametres ?? "us", category: selectedGeneralCategory?.requestParametres ?? "general") { [weak self] news, error in
            guard let self = self else { return }
            if let error = error {
                self.showError(error.localizedDescription)
                print(error)
            } else {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
    
    private func showError(_ error: String) {
        let alertController = UIAlertController()
        alertController.message = error
        alertController.addAction(.init(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        let post = news[indexPath.row]
        cell.authorLabel.text = post.author
        cell.discriptionLabel.text = post.description
        cell.publistedatLabel.text = post.publishedAt
        cell.titleLabel.text = post.title
        cell.setImage(model: post)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
    
}

//MARK: - PickerView

private extension NewsListViewController {
    
    func setupCountryCategoryPicker() {
        countryCategoryPicker.delegate = self
        countryCategoryPicker.dataSource = self
        
        let toolbarWidth = view.bounds.width
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: toolbarWidth, height: 44)))
        
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(countryCategoryDoneTapped))
        
        let spase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spase, done], animated: false)
        
        countryTextField.inputAccessoryView = toolbar
        countryTextField.inputView = countryCategoryPicker
    }
    
    func setupGeneralCategoryPicker() {
        generalCategoryPicker.delegate = self
        generalCategoryPicker.dataSource = self
        
        let toolbarWidth = view.bounds.width
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: toolbarWidth, height: 44)))
        
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(categoryGeneralDoneTapped))
        
        let spase = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spase, done], animated: false)
        
        categoryTextField.inputAccessoryView = toolbar
        categoryTextField.inputView = generalCategoryPicker
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension NewsListViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if countryTextField.isEditing {
            return countryCategory.count
        } else {
            return generalCategory.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if countryTextField.isEditing {
            return countryCategory[row].title
        } else {
            return generalCategory[row].title
        }
    }
}

//MARK: - UITextFieldDelegate

extension NewsListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    @discardableResult
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case countryTextField:
            view.endEditing(true)
        case categoryTextField:
            view.endEditing(true)
        default:
            fatalError()
        }
        return true
    }
}
