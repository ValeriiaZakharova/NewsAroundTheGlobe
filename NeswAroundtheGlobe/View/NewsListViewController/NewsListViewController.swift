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
    
    @IBOutlet private weak var countryTextField: UITextField!
    
    @IBOutlet private weak var categoryTextField: UITextField!
    
    private var viewModels: [NewsViewModel] = []
    
    private let countryCategoryPicker = UIPickerView()
    
    private let generalCategoryPicker = UIPickerView()
    
    private let countryCategory = CountryCategory.allCases
    
    private let generalCategory = GeneralCategory.allCases
    
    private var selectedCountryCategory: CountryCategory?
    
    private var selectedGeneralCategory: GeneralCategory?
    
    private let networkProvider = NetworkProvider()
    
    private let spinner = UIActivityIndicatorView()
    
    private var totalResults: Int = 0
    
    private var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        setupCountryCategoryPicker()
        setupGeneralCategoryPicker()
        setupTextfield()
        setupSpinner()
        reloadFeed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    @objc
    func countryCategoryDoneTapped() {
        let row = countryCategoryPicker.selectedRow(inComponent: 0)
        selectedCountryCategory = countryCategory[row]
        countryTextField.text = selectedCountryCategory?.title
        textFieldShouldReturn(countryTextField)
        reloadFeed()
    }
    
    @objc
    func categoryGeneralDoneTapped() {
        let row = generalCategoryPicker.selectedRow(inComponent: 0)
        selectedGeneralCategory = generalCategory[row]
        categoryTextField.text = selectedGeneralCategory?.title
        textFieldShouldReturn(categoryTextField)
        reloadFeed()
    }
    
    /// updates a single news in viewModels array after being picked favorite
    func updateNews(news: NewsViewModel) {
        guard let index = findNewsIndex(identifier: news.identifier) else { return }
        viewModels[index] = news
        tableView.reloadData()
    }
    
    /// finds index of a single news in viewModels array by source.id
    func findNewsIndex(identifier: UUID) -> Int? {
        let newsIndex = viewModels.firstIndex(where: { internalNews -> Bool in
            return internalNews.identifier == identifier
        })
        return newsIndex
    }
    
    //MARK: - Private
    
    private func getNews(page: Int) {
        networkProvider.fetchNews(country: selectedCountryCategory?.requestParametres ?? "us", category: selectedGeneralCategory?.requestParametres ?? "general", page: page) { [weak self] news, totalResults, error  in
            guard let self = self else { return }
            if let error = error {
                self.showError(error.localizedDescription)
                print(error)
            } else {
                let viewModels = news.map({ model -> NewsViewModel in
                    return NewsViewModel(source: model.source, author: model.author, title: model.title, description: model.description, url: model.url, urlToImage: model.urlToImage, publishedAt: model.publishedAt, content: model.content, isFavorite: false, identifier: UUID())
                })
                self.viewModels.append(contentsOf: viewModels)
                self.totalResults = totalResults ?? 0
                self.tableView.reloadData()
            }
        }
    }
    
    private func reloadFeed() {
        viewModels = []
        page = 1
        getNews(page: 1)
    }
    
    private func getMoreNews() {
        page = page + 1
        getNews(page: page)
    }
    
    private func setupSpinner() {
        spinner.style = .medium
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(40))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = true
    }
    
    private func setupTextfield() {
        countryTextField.delegate = self
        categoryTextField.delegate = self
        countryTextField.tintColor = UIColor.clear
        categoryTextField.tintColor = UIColor.clear
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
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.delegate = self
        let post = viewModels[indexPath.row]
        cell.authorLabel.text = post.author
        cell.discriptionLabel.text = post.description
        cell.publistedatLabel.text = post.publishedAt
        cell.titleLabel.text = post.title
        cell.setImage(model: post)
        
        /// attached selected button to favorite post
        cell.bookmarkButton.isSelected = post.isFavorite
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModels.count - 1 {
            if viewModels.count < totalResults {
                print(viewModels.count)
                print(totalResults)
                spinner.startAnimating()
                self.tableView.tableFooterView?.isHidden = false
                self.getMoreNews()
            } else {
                spinner.stopAnimating()
                self.tableView.tableFooterView?.isHidden = true
            }
        }
    }
}

//MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewsWebViewController") as! NewsWebViewController
        
        vc.url = viewModels[indexPath.row].url
        navigationController?.pushViewController(vc, animated: true)
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

//MARK: - PickerView

private extension NewsListViewController {
    
    /// Refactor these two function: setupCountryCategoryPicker and setupGeneralCategoryPicker, make sure there is one function for both pickers
    
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

extension NewsListViewController: NewsCellDelegate {
    
    func saveToBookmark(cell: NewsCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var post = viewModels[indexPath.row]
        
        if !cell.bookmarkButton.isSelected {
            /// changes post.isFavorite = true to put news to favorite and updates viewmodels array
            post.isFavorite = true
            NewsDataController.shared.add(news: post)
            self.updateNews(news: post)
            cell.bookmarkButton.isSelected = true
        } else {
            NewsDataController.shared.remove(news: post)
            post.isFavorite = false
            self.updateNews(news: post)
            cell.bookmarkButton.isSelected = false
        }
    }
    
    func sharePost(cell: NewsCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let post = viewModels[indexPath.row]
        let items = [post.url]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
