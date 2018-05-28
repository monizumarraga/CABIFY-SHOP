#Cabify Challenge
#Monica Zumarraga
#May 2018


#sumary
#	El módulo General_functions es el módulo que engloba las condiciones de validación de los datos introduidos por teclado
#methods
#	question: este método es para las preguntas generales con valores delimitados
#		parameters
#			message: mensaje de pregunta a mostrar en pantalla
#			list: listado de valores posibles
#		return
#			question: el valor introducido por teclado
#		remarks
#			repetirá la pregunta hasta que el valor introducido por teclado sea uno de los de la lista recibida 
#	name_verif: este método es para validar que el nombre del nuevo usuario no está ya registrado ni sea nulo
#		parameters
#			message: mensaje de pregunta a mostrar en pantalla
#			message1: mensaje de error en caso de no cumplir las condiciones
#			list: listado de usuarios registrados
#		return
#			question: el valor introducido por teclado
#		remarks
#			repetirá la pregunta hasta que el valor introducido por teclado no sea uno de los de la lista recibida ni esté en blanco
#	email_verif: este método es para validar que el email cumple con el formato de direcciones de correo
#		parameters
#			message: mensaje de pregunta a mostrar en pantalla
#		return
#			question: el valor introducido por teclado
#		remarks
#			repetirá la pregunta hasta que el valor del email coincida con el formato de direcciones de correo
#	pss_verif: este método es para validar que la contraseña elegida tiene al menos X caracteres
#		parameters
#			message: mensaje de pregunta a mostrar en pantalla
#			len: longitud de caracteres requerida
#		return
#			question: el valor introducido por teclado
#		remarks
#			repetirá la pregunta hasta que el número de caracteres sea igual o superior al solicitado
#	email_send: este método es para enviar correos
#		parameters
#			from: dirección que envía el correo
#			to,: dirección a la que se envía el correo
#			subject: asunto del correo
#			message: cuerpo del correo
#		remarks
#			muestra en pantalla el email enviado
module General_functions
	def question (message, list)
		error=false
		begin
			puts ()
			puts("**********************".center(WINDOW_WIDTH))
			puts message.center(WINDOW_WIDTH)
			puts ("#{list}".center(WINDOW_WIDTH))
			puts("**********************".center(WINDOW_WIDTH))
			question=gets().chomp.upcase
			if !list.include?(question)
				error=true
				puts
				puts ("Option not valid.")
				puts
			else
				error=false
			end
		end while error
		return question
	end

	def name_verif (message, message1, list)
		error=false
		begin
			print (message)
			user_name= gets().chomp.upcase
			if list.include?(user_name) == true or user_name==""
				puts ("\t\t" + message1)
				error=true
			end
		end while error
		return user_name
	end

	def email_verif (message)
		error=false
		begin
			print (message)
			user_email= gets().chomp
			if !(user_email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
				puts("\t\tEmail entered not valid")
				error=true
			else
				error=false
			end
		end while error
		return user_email
	end
	
	def pss_verif (message, len)
		error=false
		begin
			print (message)
			user_pss= gets().chomp.to_s
			if (user_pss.length < len.to_i)
				puts("\t\tPassword must be at least #{len} characters.")
				error=true
			else
				error=false
			end
		end while error
		return user_pss
	end

	def email_send (from, to, subject, message)
		puts("Email sent to #{to}")
		puts("".center(WINDOW_WIDTH,"-"))
		puts("From: #{from}")
		puts("To: #{to}")
		puts("Subject: #{subject}")
		puts(message)
		puts("".center(WINDOW_WIDTH,"-"))
	end
end


#sumary:
#	La clase Usuario incluye las caracteristicas de definición de los diferentes usuarios que se conectan a la aplicación
#parameters:
#	name: nombre de acceso. No se permiten dos usuarios con el mismo nombre
#	email: dirección de correo asociada al cliente
#	password: contraseña de acceso del usuarios
#	cart: carro del usuario durante la sesión abierta
#	money: monedero del usuario
#remarks:
#	para el ejercicio se ha inicializado el monedero en 100 para facilitar el uso. En realidad se debiera incluir un sistema de pago seguro por internet en vez de un monedero
class User 
	attr_accessor :name
	attr_accessor :email
	attr_accessor :password
	attr_accessor	:cart
	attr_accessor	:money

	def initialize (aName, aEmail, aPassword)
		@name=aName	
		@email=aEmail	
		@password = aPassword	
		@cart=Hash.new()
		@money=100.00
	end

end

#sumary
#	La clase Users_registered es un listado de los usuarios registrados
#parameters
#	user_list: listado de usuarios conectados
#methods
#	initialize: método de inicialización del proceso de Users_registered
#		remarks
#			crea el nuevo listado de usuarios
#	new_user_connection: este método es el que se encarga de preguntar si se accede como usuario registrado o se da de alta uno nuevo
#		parameters
#			user_name: recibe el nombre del usuario activo 
#		return
#			user_name: nombre de usuario activo
#			user_list[user_name].cart: carro de compra del usuario activo
#		remarks
#			si el usuario es nuevo llama al procedimiento de crear un nuevo usuario, si es viejo llama al de verificar la conexiñon del usuari
#	create_new_user: este método es el que solicita al usuario los datos de registro del nuevo usuario
#		return
#			user_name: nombre de usuario activo
#			user_list[user_name].cart: carro de compra del usuario activo
#		remarks
#			llama a las funciones de verificación de cada dato y pasa  al método correspondiente los parámetros para dar de alta el nuevo usuario
#	create_new_user: este método es el que solicita al usuario los datos de registro del nuevo usuario
#		parameters
#			user_name: nombre de usuario a dar de alta
#			user_email: dirección de correo asociada al usuario a dar de alta
#			user_pss: contraseña de acceso del usuario a dar de alta
#		remarks
#			incluye en el listado de usuarios el nuevo cliente
#	user_connection_logout: este método es el que se encarga de cerrar la conexión de un usuario conectados (borrar carro9 o de cambiar el usuario activo
#		parameters
#			user_name: recibe el nombre del usuario activo para comprobar la desconexión o cambio de usuario en activo
#		return
#			user_name: nombre de usuario activo (por si se ha querido cambiar la conexión del usuario)
#			user_list[user_name].cart: carro de compra del usuario activo
#			log_out: 'YES' si el usuario se ha querido desconectar, 'NO' si no
#		remarks
#			en caso de salir, pregunta si se quiere acceder con otro usuario
#	users_registered: este método es el que lista los usuarios registrados
#		parameters
#			user_name: recibe el nombre del usuario activo
#		return
#			user_name: nombre de usuario activo
#			user_list[user_name].cart: carro de compra del usuario activo
#		remarks
#			solicita nombre de usuario y contraseña de acceso. En caso de que no se introduzca la contraseña correctamente se pide cambiar de usuario
#	check_pss: este método es el que se encarga de comprobar la contraseña del usuario activo. Limitando el número de intentos a 3
#		parameters
#			user_name: recibe el nombre del usuario activo para comprobar la contraseña correspondiente
#		return
#			'TRUE' si se ha introducido bien la contraseña
#			'FALSE' si no la ha introducido correctamente
#		remarks
#			permite hasta tres intentos. En cada fallo permite solicitar el envío de la contraseña por email para recordarla
#	check_pss_rev: este método es el que se encarga de enviar un mail con la contraseña del usuario activo.
#		parameters
#			user_name: recibe el nombre del usuario activo para comprobar la contraseña correspondiente
#		remarks
#			llama al método que envía un mail al usuario activo con la contraseña que le corresponde
#	pay: este método es el que se encarga de comprobar si el usuario tiene dinero suficiente para pagar (previa solicitud de contraseña). Pidiendo ingresar dinero en caso de que no sea suficiente
#		parameters
#			user_name: recibe el nombre del usuario activo para comprobar la disponibilidad de dinero
#			amount: precio total del carro del usuario activo
#		return
#			'TRUE' si se ha tiene dinero suficiente
#			'FALSE' si no tiene dinero y no quiere ingresarlo, si ha habido un problema con la contraseña
#	pay_action: este método es el que se encarga de actualizar el monedero y carro una vez que se confirma la acción de pago
#		parameters
#			user_name: recibe el nombre del usuario activo para comprobar la disponibilidad de dinero
#			amount: precio total del carro del usuario activo
#		remarks
#			La llamada a este método se hace tras las comprobaciones de disponibilidad de dinero, contraseña y disponibilidad de producto
#	get_cart : este método es el que devuelve el carro del usuario conectado
#		parameters
#			user_name: recibe el nombre del usuario activo para devolver el carro
#		return
#			@user_list[user_name].cart: carro de compra del usuario conectado
#	delete_cart : este método es el que borra el contenido del carro del usuario conectado
#		parameters
#			user_name: recibe el nombre del usuario activo`para vaciar el carro
#		return
#			@user_list[user_name].cart: carro de compra del usuario conectado
#remarks
#	Se ha creado este listado de usuarios registrados para mostrar la posibilidad de manejo simultáneo de información de diferentes usuarios mediante el acceso a los parámetros del usuario en activo
#	No se debería mostrar la lista de usuarios registrados, pero se hace en esta fase para facilitar el manejo del programa.
#improvements
#	Una correcta gestión sería crear una BBDD con los usuarios registrados en el sistema y que la ejecución del programa fuese independiente para cada uno de ellos
#	En el método check_pss, se podría ampliar el chequeo de contraseña a solicitar un correo si no se acuerda de la contraseña y restaurar la contraseña.
#	Crear un nuevo método con llamada desde el menú principal para modificar el dinero del monedero (añadiendo o retirando)
#	Incluir doble introducción de contraseña para verificar que se ha seleccionado correctamente
#	Incluir posibilidad de 'EXIT' en cualquir momento

class Users_registered 
	@user_list
	attr_accessor :user_list
	include General_functions

	def initialize
		@user_list=Hash.new()
	end

	def new_user_connection (user_name)
		puts("---USER CONNECTION--- ")
		if user_name ==""
			new_user = question "Are you a new user or an already existing one? (NEW/OLD)", ["NEW", "OLD"]
		else
			new_user = question "Are you a new user or an already existing one?Or select CANCEL (NEW/OLD)", ["NEW", "OLD","CANCEL"]
		end
		if new_user == "NEW"
			user_name, cart = create_new_user()
		elsif new_user == "OLD"
			user_name, cart = users_registered user_name
		end
		return user_name, @user_list[user_name].cart
	end

	def create_new_user ()
			puts ()
			puts ("".center(WINDOW_WIDTH, "*"))
			puts ("WELCOME TO CABIFY SHOP".center(WINDOW_WIDTH))
			puts ("".center(WINDOW_WIDTH, "*"))
			list=@user_list.keys
			user_name = name_verif "Enter name: \t \t \t \t", "User #{user_name} is aready connected. \nIntroduce a none connected user name", list
			user_email= email_verif "Enter email: \t \t \t \t"
			user_pss = pss_verif "Enter password: (at least 4 characters)\t", 4
			include_user_list user_name, user_email, user_pss
		return user_name, @user_list[user_name].cart
	end

	def include_user_list (user_name,user_email,user_pss)
		user = User.new(user_name,user_email,user_pss)
		@user_list[user_name] = user
		puts("User created correctly")
		puts()
	end

	def user_connection_logout (user_name)
		cart=@user_list[user_name].cart
		puts()
		puts("---LOGOUT---")
		log_out = question "Do you want to exit form Cabify Shop? (YES/NO)", ["YES", "NO"]
		if log_out == "YES"
			@user_list[user_name].cart.clear
			user_name=""
			cart=""
		end
		return user_name, cart, log_out
	end

	def user_change (user_name)
		puts()
		puts("---CHANGE USER--- ")
		user_change = question "Do you want to change your login user to another one? (YES/NO)", ["YES", "NO"]
		if user_change == "YES" or user_name=="" then
			user_name, cart = new_user_connection user_name
			else
				cart=@user_list[user_name].cart
		end
		return user_name, cart
	end

	def users_registered (user_name)
		user_name= question "Select username or select NEW user. \nUsers actually declared are: #{@user_list.keys}", @user_list.keys.push("NEW")
		case (user_name)
		when "NEW"
			user_name, cart = create_new_user()
		else
			pass_check=check_pss(user_name)
			if pass_check == true then
				cart=@user_list[user_name].cart
			else
				user_name, cart=new_user_connection user_name
			end
		end
		return user_name, cart
	end


	def check_pss (user_name)
		pass_count=0
		puts("Introduce your password:")
		begin 
			pss=gets().chomp
			if pss == @user_list[user_name].password then 
				return true
			else
				if pass_count==2 then
					puts ("There are no more tries.")
				else
					puts ("Password failed.")
					rec_pss_ans = question "Do you want to recover Password? (YES/NO)", ["YES", "NO"]
					if rec_pss_ans == "YES" then
						check_pss_rev (user_name)
					end
					puts ("Password failed. Try again.")
				end
				pass_count	= pass_count + 1
			end
		end while (pss != @user_list[user_name].password and pass_count < 3)
		return false
	end

	def check_pss_rev (user_name)
		puts("\n\n\n")
		email_send "Cabify", @user_list[user_name].email, "Cabify password recover", "Your Cabify user´s password is #{@user_list[user_name].password}"
		puts("\n\n\n")
	end

	def pay (user_name, amount)
		pass_check=check_pss(user_name)
		if pass_check == true
				if @user_list[user_name].money >= amount.to_f
				 	return true
				 else
				 	puts ("There is not enought money in your wallet.")
				 	wallet_ans = question "Do you want to upload funds to your wallet? (YES/NO)", ["YES", "NO"]
					if wallet_ans == "YES" then
						puts("Amount?")
						wallet_mon=gets().chomp.to_f
						@user_list[user_name].money = @user_list[user_name].money.to_f + wallet_mon
						proc_pay = pay user_name, amount
						if proc_pay ==true then
							return true
						end
					end
			 	end 
		else
			puts ("Your cart content has been deleted")
			@user_list[user_name].cart.clear
		end
		return false
	end

	def pay_action (user_name, amount)
		puts("\n\n\n")
		mess=""
		@user_list[user_name].cart.each do |key, value| 
			units = @user_list[user_name].cart[key].to_s
			mess=mess + key + "\t" + units + " u. \n"
		end
		mess=mess + 'Total amount: '+ amount.to_s
		email_send "Cabify", @user_list[user_name].email, "Cabify purchase order", mess
		puts("\n\n\n")
		@user_list[user_name].money=@user_list[user_name].money - amount.to_f
		@user_list[user_name].cart.clear
	end

	def get_cart (user_name)
		return @user_list[user_name].cart
	end

	def delete_cart (user_name)
		@user_list[user_name].cart.clear
		return @user_list[user_name].cart
	end

end

#sumary
#	El módulo Cabify_products es un listado de los productos disponibles para comprar
#parameters
#	order_units: listado de productos
#	list_prod: listado de productos
#class
#	Product: La clase Product incluye las caracteristicas de definición de los diferentes productos disponibles para venta
#		parameters:
#			code: código del producto. No se permiten dos productos con el mismo código 
#			name: descripción del producto
#			price: precio del profucto
#			units: unidades disponibles del producto
#			discount: descuento aplicado al producto
#		methods
#			initialize: método de inicialización del producto
#				parameters:
#					aCode: código del producto.
#					aName: descripción del producto
#					aPrice: precio del profucto
#					aUnits: unidades disponibles del producto
#					aDiscount: descuento aplicado al producto
#		remarks:
#			para el ejercicio se ha asignado a cada producto una cantidad por defecto de unidades a pedir al quedarse sin stock (order_units)
#			cada vez que se crea un nuevo producto, se da de alta en el listado de productos disponibles
#			la disponibilidad de unidades disminuye cuando se efectua el proceso de pago, no por la reserva en el carro. Al ir a hacer el pago se vuelve a comprobar la disponibilidad por si otro usuario las ha comprado en paralelo 
#methods
#	get_put_list_prod: este método es el que muestra los códigos y descripción de los productos disponibles
#		return
#			list: lista de productos disponibles
#	get_list_prod: este método es el que mdevuelve la lista de los productos disponibles
#		return
#			list: lista de productos disponibles
#	check_availab: este método es el que comprueba si hay disponibilidad suficiente de un determinado producto
#		parameters
#			prod: código del producto a comprobar
#			qty: cantidad deseada del producto
#		return
#			'TRUE' si se tiene cantidad suficiente
#			'FALSE' si no se tiene cantidad suficiente
#		remarks
#			si no hay suficiente cantidad llama a la actualización de producto disponible
#	order_avail: este método es el que comprueba si hay disponibilidad suficiente de los productos y cantidades del carro del usuario conectado
#		parameters
#			cart: carro de compra del usuario conectado
#		return
#			'TRUE' si se tiene cantidad suficiente
#			'FALSE' si no se tiene cantidad suficiente
#		remarks
#			llama al método de comprobación de producto check_availab
#	order_checkout: este método es el que descuenta de la lista de productos disponibles los artículos del carro
#		parameters
#			cart: carro de compra del usuario conectado
#		remarks
#			a este método se le llama una vez validado el pago y comprobada la disponibilidad
#	out_of_stock: este método es el que amplia la disponibilidad de unidades del producto recibido
#		parameters
#			prod: código del producto del que ampliar unidades disponibles
#		remarks
#			a este método se le llama cada vez que se comprueba que no hay suficientes unidades de un artículo
#remarks
#	Se ha creado este listado de productos disponibles para gestionar los diferentes productos y unidades disponibles y gestionar la actualización de los mismos al realizar pedidos y quedarse sin stock
#improvements
#	Una correcta gestión sería crear una BBDD con el listado de productos disponible que se fuera actualizando del mismo modo que este listado
#	la gestión de ampliar disponibilidad de producto (out_of_stock) debiera ser supervisada por el administrador. Se debiera enviar una notificación cada vez que un producto esté por debajo de un límite para evitar quedarse sin stock y que fuera el administrador quien se encargara de gestionar la compra y actualizar la disponibilidad de productos cuando se reciba la mercancía
#	Si no se hace una BBDD de productos, que exista la posibilidad de crear productos de forma dinámica por el administrador
module Cabify_products
	@@list=Hash.new
	attr_reader (:order_units)
	attr_writer (:order_units)
	attr_reader (:list_prod)
	attr_writer (:list_prod)
	include General_functions

	class Product
		attr_reader (:code)
		attr_writer (:code)
		attr_reader (:name)
		attr_writer (:name)
		attr_reader (:price)
		attr_writer (:price)
		attr_reader (:units)
		attr_writer (:units)
		attr_reader (:discount)
		attr_writer (:discount)

		def initialize( aCode, aName, aPrice, aUnits, aDiscount )
			@code = aCode
			@name = aName
			@price = aPrice
			@units= aUnits.to_i
			@order_units= aUnits.to_i
			@discount= aDiscount
			list_car=Hash.new
			list_car["name"]=@name
			list_car["price"]=@price
			list_car["units"]=@units.to_i
			list_car["discount"]=@discount
			list_car["order_units"]=@order_units.to_i
			@@list[@code] = list_car #aUnits.to_i, aName, aPrice, aUnits
			@list_prod=@@list
		end
	end

	def get_put_list_prod 
		@@list.each do |key, value|
			value.each do |key1, value1| 
					puts ("\t#{key1}: #{value1}") 
			end
		end
		return @@list
	end

	def get_list_prod 
		return @@list
	end

	def check_availab (prod, qty)
		if  @@list.keys.include?(prod) then
			if @@list[prod]["units"] < qty.to_i then
				puts ("Temporarily out of stock. #{prod.capitalize}, available quantity is #{@@list[prod]["units"]}")
				out_of_stock (prod)
				return false
			end
		else
			puts ("There are not #{prod}.")
			return false
		end
		return true
	end

	def order_avail (cart)
		avail=true
		cart.each do |key, value| 
			avail_prod=check_availab key, value
			if avail_prod == false then
				avail=false
			end
		end
		return avail
	end

	def order_checkout (cart)
		cart.each do |key, value| 
			 @@list[key]["units"]=@@list[key]["units"]-value
		end
	end

	def out_of_stock (prod)
		mess= "There are not enough units of #{@@list[prod]["name"]}."
		email_send "Cabify", "Cabify administrator", "Cabify Product out of Stock", mess
		@@list[prod]["units"]=@@list[prod]["units"] + @@list[prod]["order_units"]
	end
end

#sumary
#	La clase Checkout es la que gestiona el proceso de cálculo de precio delcarro en función de los precios y descuentos de los productos
#parameters
#	cart: carro de compra activo
#	total_price: precio total del carro
#	list_discount: listado de descuentos disponibles
#	list_prod: listado de productos disponibles
#methods
#	initialize: método de inicialización del proceso de Checkout
#		parameters
#			pricing_rules: array que incluye:
# 							listado de productos, disponibilidad, precio y descuento de cada uno de ellos
# 							listado de descuentos disponibles
#		remarks
#			el listado de descuentos y métodos asociados se definen por programación
#	scan: método para ampliar en una unidad el producto del carro
#		parameters
#			prod: código del producto del que ampliar unidades
#		remarks
#			por la definición del enunciado se ha dejado que el escaneado sea por unidades, pero mediante la función update_cart se podría elegir la cantidad total directamente. Ahora se ha habilitado sólo desde la revisión del carro
#	view_cart: método para mostrar en pantalla el carro de compra activo con unidades y precios
#	calc_tot_price: método para calcular gestionar la compra del carro, calculando el precio del carro en función de los productos, unidades y descuentos del mismo
#		return
#			'TRUE' si se quiere proceder al pago
#			'FALSE' si no se quiere proceder al pago
#	puts_tot_price: método para mostrar en pantalla el precio total del carro de la compra y de cada uno de los productos
#	total: método para devolver el precio total del carro de la compra
#		return
#			@total_price: el precio de los productos del carro
#	calc_tot_price_prod: método para calcular el precio de un determinado producto en función de los descuentos y precios definidos para el mismo
#		parameters
#			prod: código del producto del que calcular el precio
#		return
#			price_tot_prod: precio total de las unidades del producto recibido en función de los descuentos y precios definidos para el mismo
#		remarks
#			se definen los casos de cada uno de los descuentos definidos. Se comprueba si el producto tiene alguno de los descuentos habilitados y calcula el precio correspondiente para el mismo
#	update_cart: método para modificar la cantidad de un determinado producto del carro
#		parameters
#			prod: código del producto del que ampliar unidades
#			qty: nueva cantidad de producto
#			change: booleano para determinar si modificar o ampliar la cantidad del carro
#		remarks
#			por la definición del enunciado se ha dejado que el escaneado sea por unidades, en caso de quererse escanear y elegir directamente las unidades se llamaría a la función con el change en 'FALSE'
#			en caso de que se marquen cero unidades de un producto, se elimina del carro
#	special_2_for_1: método para aplicar el descuento de 2x1
#		parameters
#			qty: cantidad de unidades en la cesta
#		return
#			num: número de unidades a cobrar
#		remarks
#			si el número de unidades a cobrar es par, devuelve la mitad. Si es un número impar, devuelve la mitad más 1
#	bulk_discount: método para aplicar el descuento de precio por cantidad
#		parameters
#			qty: cantidad de unidades en la cesta
#			prod: código del producto
#			price: precio del producto
#		return
#			price_disc: precio al que cobrar el producto
#		remarks
#			si el número de unidades supera, o iguala, el que se ha definido para aplicar el descuento, devuelve como precio a usar el del descuento. En caso contrario sería el precio definido para el artículo
#improvements
#	Posibilidad de crear métodos de forma dinámica para la definición de descuentos disponibles, ampliando a su vez el listado de descuentos y los casos de la función calc_tot_price_prod
class Checkout
  	attr_reader (:cart)
    attr_writer (:cart)
  	attr_reader (:total_price)
    attr_writer (:total_price)
  	attr_reader (:list_discount)
    attr_writer (:list_discount)
  	attr_reader (:list_prod)
    attr_writer (:list_prod)
	include General_functions

	def initialize(pricing_rules) 
	@total_price=0.0
	@list_discount=pricing_rules[1]
	@cart = Hash.new
	@list_prod=pricing_rules[0]
	end

	def scan(prod)
	@cart[prod] = @cart[prod].to_i + 1
	end 

	def view_cart ()
	puts
	puts("---CART---")
	puts("".center(WINDOW_WIDTH, "-"))
	if @cart .keys.count==0 then
	  puts("0 Items".rjust(WINDOW_WIDTH))
	else
		puts_tot_price
	end
	end

	def calc_tot_price
		puts()
		puts("---PAY---")
		puts("".center(WINDOW_WIDTH, "-"))
		puts_tot_price
		pay_ans = question "Do you want to proceed with the purchase? (YES/NO)", ["YES", "NO"]
		if pay_ans=="YES" then
			return true
		else
			return false
		end
	end	

	def puts_tot_price
		@total_price=0.0
		@cart.each do |key| 
			prod=key
			tot_ind = calc_tot_price_prod (prod)
			@total_price =@total_price.to_f + tot_ind.to_f
			print ("#{prod[0]}:".ljust(WINDOW_WIDTH/2) + "#{prod[1]} u     #{tot_ind} €".rjust(WINDOW_WIDTH/2))
			puts
		end
		puts("".center(WINDOW_WIDTH, "_"))
		puts
		print ("TOTAL       #{@total_price} €".rjust(WINDOW_WIDTH))
		puts
	end

	def total 
		return @total_price
	end

	def calc_tot_price_prod (prod)
		prod_qty=@cart[prod[0]]
		prod_price= @list_prod[prod[0]]["price"]
		prod_disc = @list_prod[prod[0]]["discount"][0]
		case (prod_disc)
			when "special_2_for_1"
				prod_qty = special_2_for_1 (prod_qty)
			when "bulk_discount"
				prod_price = bulk_discount prod_qty, prod, prod_price
			else	
		end
		price_tot_prod = prod_price.to_f * prod_qty.to_i
		return price_tot_prod
	end	

	def update_cart ( prod, qty, change)
		if change == "TRUE" or !@cart.keys.include?(prod) then
		  @cart[prod] = qty
		else
		  @cart[prod] = @cart[prod].to_i + qty
		end
		if @cart[prod] == 0 then
			@cart.delete(prod)
		end
	end

	def special_2_for_1 (qty)
		num=qty.to_i
		if (num % 2)==0 then
  		 	num= num / 2
  		else 
  			num =  num / 2 + 1
  		end
  		return num
  	end

  	def bulk_discount (qty, prod, price)
		qty_disc = @list_prod[prod[0]]["discount"][1]
		price_disc= price.to_f
  		if qty >= qty_disc.to_i then
			price_disc= @list_prod[prod[0]]["discount"][2].to_f
  		end
  		return price_disc
  	end  

  	def get_cart_list ()
  		return cart.keys
  	end
end

#sumary
#	El método menu es el que se encarga de mostrar en pantalla las opciones disponibles del menú
#improvements
#	Crear un interfaz gráfico para el menú
#	En todas las preguntas lanzadas al usuario (en este método, en los demás, así como en clases y métodos) se ha limitado a que las respuestas introducidas por teclado se correspondan a un valor determinado. En el interfaz gráfico se modificaría por botones de aceptación o rechazo
def menu ()
	include General_functions
	puts ("\n\n\n")
	puts ("------------------SHOP------------------".center(WINDOW_WIDTH,"-"))
	puts ("SHOP for products scan")
	puts
	puts ("------------------CART------------------".center(WINDOW_WIDTH,"-"))
	puts ("CART for review cart products")
	puts
	puts ("------------------PAY------------------".center(WINDOW_WIDTH,"-"))
	puts ("PAY for pay process")
	puts
	puts ("------------------CHANGE USER------------------".center(WINDOW_WIDTH,"-"))
	puts ("USER for change user")
	puts
	puts ("------------------EXIT------------------".center(WINDOW_WIDTH,"-"))
	puts ("EXIT for exit")
	menu_sel = question "Select", ["SHOP", "CART", "PAY", "USER", "EXIT"]
	return menu_sel
end

#sumary
#	El método menu_sel_prod es el que se encarga de mostrar en pantalla la lista de productos disponibles para seleccionar
#parameters
#	cabify_prod: lista de productos disponibles
#	prod_list_sel: lista de posibles productos a seleccionar
#   delete: booleano para permitir llamar a borrar el contenido del carro
#remarks
#	se ha creado un menú dinámico en función de la lista de productos que muestre los códigos y descripciones dadas de alta
def menu_sel_prod (cabify_prod, prod_list_sel, delete)
	puts
	puts ("--------------SCAN PRODUCT--------------".center(WINDOW_WIDTH))
	cabify_prod.each do |key, value| 
		if prod_list_sel.include?(key) then
			puts
			if cabify_prod[key]["units"]==0 then
				print ("#{key}- #{cabify_prod[key]["name"]}:".ljust(WINDOW_WIDTH/3," "))
				print("Out of stock".rjust(WINDOW_WIDTH*2/3," ")) 
			else
				print ("#{key}- #{cabify_prod[key]["name"]}:".ljust(WINDOW_WIDTH/3," "))
				print("#{cabify_prod[key]["units"]} units available [#{cabify_prod[key]["price"]} €/u] [#{cabify_prod[key]["discount"][0]}]".rjust(WINDOW_WIDTH*2/3," ")) 
			end
		end
	end
	if delete== true then
		prod = question "Select product, Delete content or Cancel", prod_list_sel.push("DELETE", "CANCEL")
	else
		prod = question "Select product or Cancel", prod_list_sel.push("CANCEL")
	end
	return prod
end

#sumary
#	El proceso principal de gestión de la tienda virtual
#remarks
#	Pasos de ejecución:
#		Inclusión del módulo de Cabify_products
#		Dar de alta la lista de productos
#		Crear los productos con características y descuentos
#		Dar de alta la lista de usuarios conectados
#			Se ha incluido un usuario por código para tener un primer cliente con el que poder acceder como ya registrado
#		Dar de alta el proceso de Ckeckout
#		Acceso a la tienda
#			Si no es la primera conexión, se consutla la desconexión o cambio de usuario
#			Acceder como nuevo usuario (si es la primera vez) o si se ha desconectado el usuario anterior 
#			Con un usuario activo se muestra el menú de posibilidades y en función de la selección se puede
#				Comprar
#					Selección de producto a añadir (escaneado de una única unidad)
#				Pagar: 
#					Comprobar precio y consultar si se desea proceder al pago
#					Comprobar disponibilidad de dinero en el monedero del usuario activo
#					Comprobar disponibilidad de producto
#					Pago con actualización de productos disponibles, dinero y carro del usuario activo
#				Ver el carro
#					Mostrar el carro
#					Solicitar confirmación de contenido o actualización del mismo
#				Salir
#		Los procesos de dar de alta, baja, comprar, escanear, actualizar se han definido en detalle en las clases, módulos y métodos correspondientes
#improvements
#	Crear un menú paralelo para el usuario administrador para la gestión de dar de alta productos, actualizar stock, crear y aplicar nuevos descuentos


include Cabify_products
include General_functions

WINDOW_WIDTH = 80

Cabify_products.list_prod

voucher=Product.new("VOUCHER", "Cabify Voucher", 5.00, 100, ["special_2_for_1", "", ""])
t_shirt=Product.new("TSHIRT", "Cabify T-shirt", 20.00, 100, ["bulk_discount", "3", "19.00"])
mug=Product.new("MUG", "Cabify Mug", 7.50, 100, ["", "", ""])


user_list=Users_registered.new()
user_list.include_user_list "MONICA", "monizumarraga@hotmail.com", "1234"
user_start=true
user_name=""
log_out="NO"

pricing_rules=[get_list_prod, ["special_2_for_1","bulk_discount"]]
co=Checkout.new(pricing_rules)

puts()
puts("CABIFY SHOP".center(WINDOW_WIDTH, "*"))
puts()

user_name, co.cart = user_list.new_user_connection ""

begin
	if user_start!=true
		user_name, co.cart, log_out = user_list.user_connection_logout(user_name)
	end
	user_start=false


	if user_name !="" and log_out!= "YES" then
		begin
			list_prod= get_list_prod
			menu_sel= menu
			case (menu_sel)
				when "SHOP"
					prod= menu_sel_prod list_prod, list_prod.keys, false
					#begin
					#	print("\n \t Purchase items: \t")
					#	num_prod=gets().chomp.to_i
					#	if co.cart.has_key?(prod) then
					#		act_qty=co.cart[prod] + num_prod
					#	else
					#		act_qty=num_prod
					#	end
					#end while !list_prod.check_availab(prod,act_qty)
					#co.update_cart(prod, num_prod, "FALSE")
					case (prod)
					when "CANCEL"
					else
						begin
							if co.cart.has_key?(prod) then
								act_qty=co.cart[prod] + 1
							else
								act_qty=1
							end
							if list_prod.check_availab(prod,act_qty) then
								co.scan(prod)
							end
							cont_ans = question "Do you want to continue scanning products? (YES/NO)", ["YES", "NO"]
							if cont_ans=="YES"	then
								prod= menu_sel_prod list_prod, list_prod.keys, false
							end
						end while cont_ans	=="YES"
					end
				when "PAY"
					if co.cart.length == 0
						puts("There are no articles in your cart".center(WINDOW_WIDTH,"-"))
						puts ("Enter to continue".center(WINDOW_WIDTH))
						aa=gets
					else
						pay_proc= co.calc_tot_price()
						if pay_proc == true then
							price=co.total
							pay_avail = user_list.pay user_name	, price
							if pay_avail == true then
								prod_avail=co.order_avail(co.cart)
								if prod_avail == true then
									conf_ans = question "Are you sure you want to continue with the purchase order? (YES/NO)", ["YES", "NO"]
									if conf_ans=="YES"	then
										co.order_checkout(co.cart)
										user_list.pay_action user_name	, price
									end
								end
							else
								puts ("Review your cart, there are some articles out of stock")
								co.view_cart()
							end
						end
						puts("".center(WINDOW_WIDTH,"-"))
						puts ("Enter to continue".center(WINDOW_WIDTH))
						aa=gets
					end
				when "CART"
					begin
						co.view_cart()
						if co.cart.length == 0
							cart_acc = question "There are no items in your cart. Select CANCEL and go back to the shop", ["CANCEL"]
							prod="NO"
						else
							cart_acc = question "Do you want to modify the Cart content? (YES/NO)", ["YES", "NO"]
							if cart_acc == "YES" then
								list_prod= get_list_prod
								prod= menu_sel_prod list_prod, co.get_cart_list, true
								case (prod)
								when "CANCEL"
								when "DELETE"
									co.cart=user_list.delete_cart(user_name)
								else
									begin
										print("\n \t New quantity: \t")
										num_prod=gets().chomp.to_i
									end while !list_prod.check_availab(prod,num_prod)
									co.update_cart(prod, num_prod, "TRUE")
								end
							end
						end
					end while cart_acc=="YES" and prod!="DELETE" and prod!="CANCEL"
				when "USER"
					user_name, co.cart = user_list.user_change user_name
				when "EXIT"
				else
			end
		end while menu_sel!="EXIT" 
	end 

end while log_out!="YES"

puts("\n\n\n\n\n")
puts("".center(WINDOW_WIDTH,"-"))
puts("GOODBYE".center(WINDOW_WIDTH))
aa=gets
