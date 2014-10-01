require 'sinatra'
require 'json'
require 'open-uri'
require 'csv'

before do
  content_type 'application/json'
end

get '/quote.json' do
  s = "s=#{params[:symbols]}"
  f = 'f=snl1c1p2d1t1xpobaghjkva2'

  puts "#{params}"

  quote_str = open("http://download.finance.yahoo.com/d/quotes.csv?#{f}&#{s}").read

  puts "quotes string"
  puts quote_str

  quotes = []

  CSV.parse(quote_str) do |row|
    puts "row: #{row}"

    quotes << {
      symbol: row[0],
      name: row[1],
      close: row[2],
      change: row[3],
      change_in_percent: row[4],
      last_trade_date: row[5],
      last_trade_time: row[6],
      stock_exchange: row[7],
      previous_close: row[8],
      open: row[9],
      bid: row[10],
      ask: row[11],
      low: row[12],
      high: row[13],
      low_52_week: row[14],
      high_52_week: row[15],
      volume: row[16],
      avg_daily_volume: row[17]
    }
  end

  { quotes: quotes }.to_json
end
