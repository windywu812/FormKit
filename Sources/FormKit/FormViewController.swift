//
//  FormViewController.swift
//
//
//  Created by Windy on 28/12/22.
//

import Combine
import UIKit

public final class FormViewController: UITableViewController {
    
    private var sections: [Section] = []
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }

    public convenience init(
        style: UITableView.Style = .insetGrouped,
        @FormBuilder sections: () -> [Section]
    ) {
        self.init(style: style)
        self.sections = sections()
    }

    public convenience init(
        style: UITableView.Style = .insetGrouped,
        @Section.RowBuilder rows: () -> [FormRow]
    ) {
        self.init(style: style)
        sections = [Section(rows: rows)]
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, FormRow>!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        applySnapshot()
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, FormRow>(
            tableView: tableView,
            cellProvider: { [weak self] _, indexPath, _ in
                guard let self else { return UITableViewCell() }
                let cell = self.sections[indexPath.section].rows[indexPath.row]
                cell.selectionStyle = .none
                cell.invalidateLayout = { [weak self] in
                    UIView.performWithoutAnimation {
                        self?.applySnapshot()
                    }
                }
                return cell
            }
        )
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, FormRow> {
        UITableViewDiffableDataSource<Section, FormRow>(
            tableView: tableView,
            cellProvider: { [weak self] _, indexPath, _ in
                guard let self else { return UITableViewCell() }
                let cell = self.sections[indexPath.section].rows[indexPath.row]
                cell.selectionStyle = .none
                cell.invalidateLayout = { [weak self] in
                    UIView.performWithoutAnimation {
                        self?.applySnapshot()
                    }
                }
                return cell
            }
        )
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FormRow>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.rows, toSection: section)
        }
        dataSource.apply(snapshot)
    }

}
