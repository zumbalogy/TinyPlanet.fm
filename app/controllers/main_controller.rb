class MainController < ApplicationController

    def test
        client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')

        tracks = client.get('/tracks', q: params[:city], genres: params[:genre] )
        respond_to do |format|
            format.json { render json: tracks.to_json }
        end
    end


    def index
    
    end



end
