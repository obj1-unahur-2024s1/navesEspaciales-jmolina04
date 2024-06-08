class Nave{
	var property velocidad
	var property direccion 
	var property combustible
	
	
	method acelerar(cantidad){
		velocidad += cantidad.min(100000)
	}
	method desacelerar(cantidad){
		velocidad -=cantidad
	}
	
	method irHaciaElSol(){
		direccion = 10
	}
	method escaparDelSol(){
		direccion = -10
	}
	
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = direccion + 1.between(10,-10)
	}
	
	method alejarseUnPocoDelSol(){
		direccion -= 1.between(10,-10)
	}
	
	method cargar(cant){
		combustible +=cant
	}
	
	method descargar(cant){
		combustible -= cant
	}
	
	method prepararViaje(){
		self.cargar(30000)
		self.acelerar(5000)
	}
	
	method estaTranquila(){
		return self.combustible() >= 4000 and self.velocidad()<=12000
	}
	
	method estaDeRelajo(){
		return self.estaTranquila()
	}
}

class NaveBaliza inherits Nave{
	var property color
	
	method cambiarColorDeBaliza(nuevoColor){
		color = nuevoColor
	}
	
	override method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
	}
	
	override method estaTranquila(){
		return self.color()!="rojo"
	}
	
	method recibirAmenaza(){
		self.irHaciaElSol() //escapar
		self.cambiarColorDeBaliza("rojo") //avisar
	}
	
	
}

class NavePasajeros inherits Nave{
	var property cantPasajeros
	var property racionesComida
	var property racionesBebida
	
	method cargarRacionComida(cant){
		racionesComida += cant
	}	
	
	method descargarRacionComida(cant){
		racionesComida -= cant
	}
	
	method cargarRacionBebida(cant){
		racionesBebida += cant
	}
	
	method descargarRacionBebida(cant){
		racionesBebida -= cant
	}
	
	override method prepararViaje(){
		self.cargarRacionComida(4*cantPasajeros)
		self.cargarRacionBebida(6*cantPasajeros)
		self.acercarseUnPocoAlSol()
	}
	
	method recibirAmenaza(){
		self.acelerar(velocidad) //escapar
		self.descargarRacionComida(1) //avisar
		self.descargarRacionBebida(2) 
	}
	
}

class NaveCombate inherits Nave{
	var property visibilidad
	var property misilesDesplegados
	const property mensajesEmitidos = []
	
	method ponerseVisible(){visibilidad=true}
	
	method ponerseInvisible(){visibilidad=false}
	
	method estaInvisible(){return visibilidad}
	
	method desplegarMisiles(){misilesDesplegados = true}
	method replegarMisiles(){misilesDesplegados=false}
	method misilesDesplegados(){return misilesDesplegados}
	
	method emitirMensaje(mensaje){
		mensajesEmitidos.add(mensaje)
	}
	
	method mensajesEmitidos(){
		return mensajesEmitidos
	}
	
	method emitioMensaje(mensaje){
		mensajesEmitidos.cointains(mensaje)
	}
	
	method primerMensajeEmitido(){
		return mensajesEmitidos.first()
	}
	
	method ultimoMensajeEmitido(){
		return mensajesEmitidos.last()
	}
	
	method esEscueta(){
		return mensajesEmitidos.len().max(30)
	}
	
	override method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	
	override method estaTranquila(){
		return not self.misilesDesplegados()
	}
	
	method recibirAmenaza(){
		self.alejarseUnPocoDelSol() //escapar
		self.alejarseUnPocoDelSol()
		self.emitirMensaje("Amenaza recibida") //avisar
	}
	
	override method estaDeRelajo(){
		return self.esEscueta()
	}
}


class NaveHospital inherits NavePasajeros{
	var property tieneQuirofanosPrep
	
	override method estaTranquila(){
		return tieneQuirofanosPrep
	}
	
	override method recibirAmenaza(){
		tieneQuirofanosPrep = true
	}
}


class NaveCombateSigilosa inherits NaveCombate{
	
	override method estaTranquila(){
		return self.estaInvisible()
	}
	
	override method recibirAmenaza(){
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}








