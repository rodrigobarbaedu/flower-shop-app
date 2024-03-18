class Orders:
    
    def __init__(self, id, user_id, product_id, quantity) -> None:
        
        self.id = id
        self.user_id = user_id
        self.product_id = product_id
        self.quantity = quantity