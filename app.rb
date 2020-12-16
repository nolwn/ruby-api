require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sqlite3'

db = SQLite3::Database.new 'reno_crime.db'

post '/perp' do
    api = Api.new db
    
    
    headers "Content-Type" => "application/json"
    
    perp = {
        "first_name" => "perpy",
        "last_name" => "McPerpface",
        "date_of_birth" => "10/09/1970"
    }

    api.add_perp perp
end

get '/perps' do
    api = Api.new db

    headers "Content-Type" => "application/json"

    api.get_items "perps"
end

post '/crimes' do

end

get '/crimes' do

end

class Api
    def initialize db
        @db = db
    end

    def add_perp perp
        sql = add_item "perps", perp
        
        @db.execute sql

        sql
    end

    def get_items table
        rows = @db.execute "SELECT * FROM perps"

        JSON.generate rows
    end
    
    def add_item table, item
        smt = "INSERT INTO #{table}"

        keys = item.keys
        values = item.values

        smt += sql_list(keys, true) + "\n"
        smt += " VALUES "
        smt += sql_list values, true
    end

    def sql_list list, enclosed = false
        first = true
        sql = enclosed ? "(" : ""
        sql += "\"#{list.shift}\""

        list.each do |item| 
            sql += ", \"#{item}\"" 
        end

        sql += ")" if enclosed

        sql
    end
end

