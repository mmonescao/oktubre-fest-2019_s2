//https://birrapertoriodelxino.wordpress.com/category/birrapertorio-por-paises

class CervezaRubia  {
	var property marca	
	
	method paisDeOrigen(){
		return marca.provieneDe()
	}
	
	method contenidoDeLupulo(){
		return marca.lupulo()
	}
	
	method graduacion(){
		return marca.graduacion()
	}
	
	method marca(){return marca}
	
	method precioSinRecargo(){
		return marca.precioPorLitro()
	}
}


class CervezaNegra inherits CervezaRubia { 
	
	override method graduacion(){
		return graduacionReglamentaria.graduacion().min(self.contenidoDeLupulo() * 2)
	}
}


class CervezaRoja inherits CervezaNegra {
	
	override method graduacion(){
		return super() * 1.25
	}
}

class Jarra {
	var property litrosDeJarra = 0
	var property cerveza
	var property deLaCarpa
	var property precio = 0
	
	method contenidoDeAlcohol(){
		return litrosDeJarra * (cerveza.graduacion() / 100)
	}
	
	method marcaDeJarra(){return cerveza.marca()}
	
	method precio(){return precio * litrosDeJarra}
}

object stellaArtois {	
	method provieneDe(){return belgica}
	
	method precioPorLitro(){return 80}
	
	method lupulo(){return 5}
	
	method graduacion(){return 7}
	
}

object caulier {
	method provieneDe(){return belgica}
	
	method precioPorLitro(){return 85}
	
	method lupulo(){return 3}
	
	method graduacion(){return 5}
}

object krusovice12 {
	method provieneDe(){return repCheca}
	
	method precioPorLitro(){return 90}
	
	method lupulo(){return 8}
	
	method graduacion(){return 10}
}

object bakalar {
	method provieneDe(){return repCheca}
	
	method precioPorLitro(){return 87}
	
	method lupulo(){return 9}
	
	method graduacion(){return 12}
}

object erdinger {
	method provieneDe(){return alemania}
	
	method precioPorLitro(){return 78}
	
	method lupulo(){return 2}
	
	method graduacion(){return 3}
}

object hofbrau {
	method provieneDe(){return alemania}
	
	method precioPorLitro(){return 92}
	
	method lupulo(){return 5}
	
	method graduacion(){return 8}
}

object graduacionReglamentaria {
	var property graduacion = 6.4
}

object belgica {}
object repCheca {}
object alemania {}

