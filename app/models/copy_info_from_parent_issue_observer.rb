class CopyInfoFromParentIssueObserver < ActiveRecord::Observer
  observe :issue

  def before_create(issue)
    unless issue.parent_issue_id.blank?
      parent = Issue.find_by_id(issue.parent_issue_id)
      copy_info(parent, issue) unless parent.nil?
    end
  end 

  def copy_info(parent, issue)
    if Setting.plugin_copy_info_from_parent_issue[:copy_start_date]
      if issue.start_date.blank?
        issue.logger.info "Copying start date (#{parent.start_date}) " +
                          "from parent issue (#{parent.id}) to new child issue"
        issue.start_date = parent.start_date
      end
    end

    if Setting.plugin_copy_info_from_parent_issue[:copy_due_date]
      if issue.due_date.blank?
        issue.logger.info "Copying due date (#{parent.due_date}) " + 
                          "from parent issue (#{parent.id}) to new child issue"
        issue.due_date = parent.due_date
      end
    end
  end
end
