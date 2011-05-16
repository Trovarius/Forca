class Forca
  
  def initialize(palavra = "", dificult = :easy)
    configure_word(palavra)
    configure_dificult(dificult)
    output
  end
  
  def input(letra)
    if valid_letter(letra)
      replace_letter(letra)
    else
      @dificult.add_status
    end

    output
  end

  def output
    if @jogo[:exibicao] == @jogo[:palavra] || !@dificult.can_try?
      puts "Seu Jogo terminou tente novamente"
    else
      puts "Letras conseguidas : #{@jogo[:exibicao].to_s}"
      puts ""
      puts "Status:#{@dificult}"
      puts ""
      puts "Quantidade de Chances: #{@dificult.number_of_chances}"
    end
  end
   
private 
  def configure_word(word)
    @jogo = { :palavra => word.split(//), :exibicao => word.gsub(/\w/, '_ ').split(//)}
  end

  def configure_dificult(dificult)
    @dificult = ([:easy, :medium, :hard].include? dificult) ? DificultFactory.get_dificult(dificult) : DificultFactory.get_dificult_by_word(@jogo[:palavra])
  end

  def valid_letter(letra)
    return (letra.length == 1) && (!(letra =~ /\w/).nil?) && (@jogo[:palavra].include? letra)
  end

  def replace_letter(letra)
    @jogo[:palavra].each_index do |index|
      @jogo[:exibicao][index] = letra if @jogo[:palavra][index].downcase == letra.downcase
    end
  end
end

class Dificult
  @status = []
  @actual_status = []

  def initialize(dificults = %w("cabeça corpo mãos pernas rosto"))
    @status = dificults
    @actual_status = []
  end 
  
  def add_status
    @actual_status << @status[@actual_status.length]
  end

  def can_try?
    number_of_chances > 0
  end
  
  def number_of_chances()
    @status.length - @actual_status.length
  end
  
  def to_s
     @actual_status.join(' ')
  end
end

class DificultFactory
  @dificults = {:easy => %w("cabeça corpo mãos pernas rosto"), :medium => %w("cabeça corpo resto"), :hard => %w("cabeça corpo") }

  def self.get_dificult(dificult)
    Dificult.new(@dificults[dificult] || @dificults[:hard])
  end
  
  def self.get_dificult_by_word(word)

    case word.size
      when 0..5: return Dificult.new(@dificults[:easy])
      when 6..10: return  Dificult.new(@dificults[:medium])
      else return Dificult.new(@dificults[:hard])
    end     

  end
end
