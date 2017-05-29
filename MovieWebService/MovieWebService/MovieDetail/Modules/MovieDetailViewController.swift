//
//  MovieDetailViewController.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 13/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import UIKit

protocol MovieDetailViewProtocol: class {
    func displayMovieDetail(_ movieDetail:MovieDetailViewModel)
    func displayError(_ error:String)
}


class MovieDetailViewController: BaseViewController,MovieDetailViewProtocol {
    
    // MARK:- Member Variables
    var presenter:MovieDetailPresenterProtocol!
    
    // MARK:- Outlets
    @IBOutlet weak var directorNameLabel:UILabel!
    @IBOutlet weak var actorNameLabel:UILabel!
    @IBOutlet weak var actorScreenNameLabel:UILabel!
    @IBOutlet weak var actorDetailView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MovieDetailConfig.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
        self.showNetworkActivityIndicator()
        self.presenter.fetchMovieDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    internal func displayError(_ error: String) {
        DispatchQueue.main.async {
            self.hideNetworkActivityIndicator()
        }
        print(error)
    }
    
    
    internal func displayMovieDetail(_ movieDetail: MovieDetailViewModel) {
        DispatchQueue.main.async {
            self.hideNetworkActivityIndicator()
            self.updateView(withData: movieDetail)
        }
    }
    
    private func updateView(withData data:MovieDetailViewModel )
    {
        self.directorNameLabel.text = data.directorName
        self.actorNameLabel.text = data.actorName
        
        if let actorScreenName = data.actorScreenName{
            self.actorScreenNameLabel.text = actorScreenName
        }
    }

    @IBAction func showDetailButtonTapped(_ sender: Any) {
        let showDetailButton = sender as! UIButton
        showDetailButton.isHidden = true
        self.actorDetailView.isHidden = false
    }
    
    private func setupView()
    {
        self.title = "Movie Details"
        self.directorNameLabel.text = ""
        self.actorNameLabel.text = ""
        self.actorScreenNameLabel.text = ""
        self.actorDetailView.isHidden = true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
