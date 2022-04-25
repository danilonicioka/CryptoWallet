module ApplicationHelper
    #def locale
    #    I18n.locale == :eng ? "Inglês - EUA" : "Pt-BR"
    #end
    def data_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end
    def ambiente()
        if(Rails.env.development?)
            "Desenvolvimento"
        elsif(Rails.env.production?)
            "Produção"
        else
            "Teste"
        end
    end
end
