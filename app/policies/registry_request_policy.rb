class RegistryRequestPolicy < ApplicationPolicy
    def index?
        user.present? && user.admin?
    end

    def show?
        user.present? && user.admin?
    end

    def update?
        user.present? && user.admin?
    end

    def find_registry_request?
        user.present? && user.admin?
    end
end