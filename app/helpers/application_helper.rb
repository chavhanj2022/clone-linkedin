module ApplicationHelper
    def status_of_user_connection_status( user)
        return nil if current_user == user
        
        current_user.my_connection(user).last.status
    end
end
