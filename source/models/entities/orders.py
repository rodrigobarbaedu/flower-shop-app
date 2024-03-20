class Orders:
    
    def __init__(self, id, status_order, user_id, product_id, quantity) -> None:
        
        self.id = id
        self.status_order = status_order
        self.user_id = user_id
        self.product_id = product_id
        self.quantity = quantity