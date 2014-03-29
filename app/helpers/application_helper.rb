module ApplicationHelper
    def number_to_chf(price)
        return sprintf("%0.02f CHF", price)
    end
end
