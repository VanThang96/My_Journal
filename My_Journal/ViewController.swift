//
//  ViewController.swift
//  My_Journal
//
//  Created by Nguyen Van Thang on 7/23/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tbvPosts: UITableView!
    
    var postViewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getPosts()
    }
    @IBAction func handleCreatePost(_ sender: Any) {
        postViewModel.createPost(title: "My journal", body: "Barcelona 1 - 2 Chelse") {
            self.getPosts()
        }
    }
    private func getPosts(){
        postViewModel.getPosts {
            DispatchQueue.main.async {
                self.tbvPosts.reloadData()
            }
        }
    }
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("===== Delete Post =====")
            let id = postViewModel.getPost(atIndex: indexPath.row).id
            postViewModel.deletePost(id: id) {[weak self] in
                self?.postViewModel.posts.remove(at: indexPath.row)
                self?.tbvPosts.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = postViewModel.getPost(atIndex: indexPath.row).title
        cell.detailTextLabel?.text = postViewModel.getPost(atIndex: indexPath.row).body
        return cell
    }
}
