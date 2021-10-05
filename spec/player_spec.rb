#spec/player_spec.rb
require './lib/player'

describe Player do 
    context "Checking creation of 2 Player objects" do
        player1 = Player.new('John', 'X')
        player2 = Player.new('Doe', 'O')
        
        describe "#initialize" do
            it "Should return 'John' as the first player's name" do
                expect(player1.name).to eq('John')
            end
    
            it "Should return 'X' as the first player's symbol" do
                expect(player1.symbol).to eq('X')
            end
    
            it "Should return 'Doe' as the second player's name" do
                expect(player2.name).to eq('Doe')
            end
        
            it "Should return 'O' as the second player's symbol" do
                expect(player2.symbol).to eq('O')
            end
        end
    end
end