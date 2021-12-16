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
    
    private var fetchPostListCancellationToken: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        fetcPostList()
    }
    
    private func registerTableView() {
        tableView?.register(
            PostItemTableViewCell.self,
            forCellReuseIdentifier: PostItemTableViewCell.identifier
        )
    }
    
  
    private func fetcPostList() {
        fetchPostListCancellationToken = postWorker.getAllPost()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(
                receiveCompletion: {_ in},
                receiveValue: { [weak self] in
//                    print("Post list : \($0)")
                    self?.postList = $0
                    DispatchQueue.main.async {
                        self?.tableView?.reloadData()
                    }
            })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchPostListCancellationToken?.cancel()
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
            
            print("Post item --> \(postList[indexPath.row]) \n")
            return postCell
        }
        return UITableViewCell()
    }
    
}
