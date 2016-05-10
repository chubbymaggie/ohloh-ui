module AliasScopes
  extend ActiveSupport::Concern

  included do
    scope :not_deleted, -> { where(deleted: false) }
    scope :for_project, lambda { |project|
      where(project_id: project.id)
        .where(deleted: false)
        .where.not(preferred_name_id: nil)
    }
    scope :committer_names, lambda { |project|
      Name.where(id: Commit.for_project(project).select(:name_id))
        .where.not(id: for_project(project).select(:commit_name_id))
        .where.not(id: for_project(project).select(:preferred_name_id))
        .where.not(id: Position.for_project(project).where.not(name_id: nil).select(:name_id))
        .order('lower(name)')
    }
    scope :preferred_names, lambda { |project, name_id = nil|
      Name.where(id: Commit.for_project(project).select(:name_id))
        .where.not(id: for_project(project).select(:commit_name_id))
        .where.not(id: name_id)
        .order('lower(name)')
    }
  end
end
