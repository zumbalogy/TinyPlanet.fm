class MainController < ApplicationController

    def save
        check = true
        genre_check = Combo.find_by_genre(params[:genre])
        if genre_check
            genre_check.each do |combo|
                if combo.city == params[:city]
                    check = false
                end
            end
        end
        if check
            @client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')
            @tracks = @client.get('/tracks', q: params[:city], genres: params[:genre])
     
            @combo = Combo.new
            @combo.city = params[:city]
            @combo.genre = params[:genre]
            @combo.save
    
            @tracks.each do |track|
                song = Song.new
                song.combo_id = @combo.id
                song.name = track.title
                song.url = track.uri
                song.soundcloud_id = track.id
                song.waveform_url = track.waveform_url
                song.artwork_url = track.artwork_url
                song.artist = track.user.username
                song.save
            end
        end
    end
    
    def serve
        combo = Combo.where("city = ? AND genre = ?", params[:city],params[:genre])
            @playlist = []
            combo.songs.each do |song|
            
            end
        end
    end

    

    def index
    
    end

    def opinion
        find = Opinion.where("song_id = ? AND user_id = ?", params[:song_id], params[:user_id])
        unless find
            foo = Opinion.new
            foo.song_id = Song.find(params[:song_id])
            foo.user_id = User.find(params[:user_id])
            foo.enjoyed = params[:opinion]
            foo.save
        else
            find.delete
        end
    end
end
