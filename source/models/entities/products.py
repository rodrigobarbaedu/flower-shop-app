class Products:
    
    def __init__(self, id, name, description, quantity, alert_quantity, price, url_image = None):
       
        self.id = id
        self.name = name
        self.description = description
        self.quantity = quantity
        self.alert_quantity = alert_quantity
        self.price = price
        self.url_image = url_image