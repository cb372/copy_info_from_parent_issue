# Plugin to copy fields from a ticket's parent at creation time.
#
require 'redmine'

Redmine::Plugin.register :copy_info_from_parent_issue do
  name 'Copy Info From Parent Issue'
  author 'Chris Birchall'
  description 'Copies field values from parent when child ticket is created'
  version '0.0.1'
  url 'https://github.com/cb372/copy_info_from_parent_issue'
  requires_redmine :version_or_higher => '2.2.0'

  settings(
    :default => { 
      :copy_start_date => false,
      :copy_due_date   => true
    },
    :partial => 'settings/copy_info_from_parent_issue_setting'
  )
end

ActiveRecord::Base.observers << :copy_info_from_parent_issue_observer

 
