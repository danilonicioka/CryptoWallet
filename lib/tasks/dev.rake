namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Deletando DB...") {%x(rails db:drop)}
      
      show_spinner("Criando DB...") {%x(rails db:create)}

      show_spinner("Executando migrations...") {%x(rails db:migrate)}

      %x(rails dev:add_mining_types)

      %x(rails dev:add_coins)
      
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
                  {
                    description: "Bitcoin",
                    acronym: "BTC",
                    url_image: "data:image/png;base64,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",
                    mining_type: MiningType.find_by(acronym: "PoW")
                  },
                  {
                    description: "Ethereum",
                    acronym: "ETH",
                    url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png",
                    mining_type: MiningType.all.sample
                  }
              ]

      coins.each do |coin|
          Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
                  {
                    description: "Proof of Work",
                    acronym: "PoW",
                  },
                  {
                    description: "Proof of Stake",
                    acronym: "PoS",
                  },
                  {
                    description: "Proof of Capacity",
                    acronym: "PoC"
                  }
              ]

      mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(start_msg, end_msg = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{start_msg}")
    spinner.auto_spin
    yield
    spinner.success("(#{end_msg})")
  end
end
