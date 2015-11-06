class RegistryRequestPolicy < ApplicationPolicy
    def index?
        user.present? && (user.admin? || user.moderator?)
    end

    def show?
        user.present? && (user.admin? || user.moderator?)
    end

    def update?
        user.present? && (user.admin? || user.moderator?)
    end
end