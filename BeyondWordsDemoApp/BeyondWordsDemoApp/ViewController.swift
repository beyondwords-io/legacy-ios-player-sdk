//
//  ViewController.swift
//  BeyondWordsDemoApp
//
//  Created by David Osorio on 28/10/2020.
//

import UIKit
import BeyondWords

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerView: PlayerView!
    typealias Article = (projectId: String, articleId: ArticleIdentifier)
    
    private let articles: [Article] = [
        ("9093", .podcastId("2653378")),
        ("9093", .url("https://www.example1.com/")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BeyondWords"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        BeyondWords.Player.shared.delegate = playerView
        
        let contentColor = UIColor.white
        let backgroundColor = UIColor.systemTeal
        
        playerView.backgroundColor = backgroundColor
        playerView.layer.cornerRadius = 8
        playerView.buttonBackgroundColor = contentColor
        playerView.buttonIconColor = backgroundColor
        playerView.progressColor = contentColor
        playerView.trackColor = contentColor.withAlphaComponent(0.3)
        playerView.textColor = contentColor
        playerView.seekingButtonsColor = contentColor
        playerView.showsSeekingButtons = true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        
        let article = self.articles[indexPath.row]
        cell.textLabel?.text = "Project \(article.projectId)"
        switch article.articleId {
        case .externalId(let id):
            cell.detailTextLabel?.text = "External - \(id)"
        case .podcastId(let id):
            cell.detailTextLabel?.text = "Podcast - \(id)"
        case .url(let url):
            cell.detailTextLabel?.text = "URL - \(url)"
        @unknown default:
            cell.detailTextLabel?.text = ""
        }
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}

// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onArticleSelected(article: articles[indexPath.row])
    }
}

extension ViewController {
    func onArticleSelected(article: Article) {
        playerView.clearPlayer()
        
        BeyondWords.Player.shared.getArticle(
            with: .init(
                projectId: article.projectId,
                articleId: article.articleId
            )) { [weak self] result in
            switch result {
            case .success(let article):
                if article.canBePlayed {
                    BeyondWords.Player.shared.playArticle(article: article, shouldAutoPlay: false)
                }
            case .failure(let error):
                self?.presentError(error: error)
            }
        }
    }
    
    func presentError(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

