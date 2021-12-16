//
//  ViewController.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    private var postList: [PostModel] = []
    private let postWorker = PostWorker.shared
    private let userWorker = UserWorker.shared
    private var fetchPostListCancellationToken: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        fetcPostList()
    }
    
    private func registerTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(
            PostItemTableViewCell.nib(),
            forCellReuseIdentifier: PostItemTableViewCell.identifier
        )
    }
  
    private func fetcPostList() {
        // Use cancellation token for disable fetch request when close this view controller
        fetchPostListCancellationToken = postWorker.getAllPost()
            // Get Post list
            .flatMap { postList in
                postList.publisher.setFailureType(to: Error.self)
            }
            // Get Post item
            .flatMap { postItem in
                // Fetch Post's User use user id
                self.userWorker.getUser(by: postItem.userId ?? 0)
                    .mapError({ (error) -> Error in
                        print("User error: \(error)")
                        return error
                    })
                    // Return with new Post for edit current Post
                    .map { userResult -> PostModel in
                        var newPostItem = postItem
                        newPostItem.user = userResult
                        return newPostItem
                    }
            }
            // Transform to back to array to render on table view
            .collect()
            .mapError({ (error) -> Error in
                print("Post error: \(error)")
                return error
            })
            // Subscribe final result
            .sink(
                receiveCompletion: {_ in},
                receiveValue: { result in
                    DispatchQueue.main.async { [weak self] in
                        self?.postList = result
                        self?.tableView?.reloadData()
                    }
            })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchPostListCancellationToken?.cancel()
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let postCell = tableView.dequeueReusableCell(
            withIdentifier: PostItemTableViewCell.identifier,
            for: indexPath
        ) as? PostItemTableViewCell {
            postCell.setData(post: postList[indexPath.row])
            return postCell
        }
        return UITableViewCell()
    }
    
}
