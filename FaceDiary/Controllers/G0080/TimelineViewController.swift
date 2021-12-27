//
//  TimelineViewController.swift
//  FaceDiary
//
//  Created by 松浦裕久 on 2021/11/22.
//

import UIKit

class TimelineViewController: BaseViewController {
    
    // view
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        // 区切り線を削除します
        tableView.separatorStyle = .none
        // tableViewのクリックイベントを無効にします
        tableView.allowsSelection = false
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初期化を行います
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Layoutの設定を行います
        setLayout()
    }
    
    // ナビゲーションバーのタイトルに表示するテキストを設定する関数です
    override func setNavTitle () -> String {
        return ""
    }
    
    // ナビゲーションバーを表示させるかを設定する関数です
    override func showNav () -> Bool {
        return true
    }
    
    // 戻るボタンを表示させるかを設定する関数です
    override func showBackButton() -> Bool {
        return false
    }
    
    // 初期化を行う関数です
    private func setUp() {

        view.addSubview(tableView)
        
        // delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // セルの登録をします
        tableView.register(TimelineCell.self, forCellReuseIdentifier: "TimelineCell")
        
    }
    
    // Layoutの設定を行う関数です
    private func setLayout() {
        
        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        tableView.frame = CGRect(x: 0, y: 0, width: getScreenWidth(), height: getScreenHeight() - getSafeAreaTop() - getNavBarHeight() - tabBarHeight)
        
    }
    
    
}

extension TimelineViewController: UITableViewDataSource {
    
    // 1section内のセルの合計値を設定します
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // セクションの数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //cellの設定を行います
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as! TimelineCell
        return cell
    }
    
    // cellの高さを設定します
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizeConst.CELL_HEIGHT
    }
    
    // Sectionのカスタマイズを行います
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // HeaderのViewを作成してViewを返す
        let headerView = UIView()
        let label = UILabel()
        label.text = "   2021 / 12"
        label.frame = CGRect(x: 0, y: SizeConst.MIDDIUM_MARGIN, width: tableView.frame.width, height: SizeConst.SECTION_LABEL_HEIGHT)
        label.textColor = ColorConst.SUB_TEXT_COLOR
        headerView.backgroundColor = .clear
        label.backgroundColor = ColorConst.SUB_COLOR
        headerView.addSubview(label)
        return headerView
    }
    
    // sectionの高さを設定します
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SizeConst.SECTION_HEIGHT + SizeConst.MIDDIUM_MARGIN * 2
    }
    
}


extension TimelineViewController: UITableViewDelegate {
    
    // スクロール時に、sectionを固定しないように設定する
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat  = 40;
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0);
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0);
        }
    }
    
}
