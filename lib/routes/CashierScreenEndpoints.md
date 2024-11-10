
- `GET /api/pos/categories` - Get product categories

```json
 Response: Response: {
  "categories": [{
    "id": "string",
    "name": "string",
    "icon": "string",
    "productsCount": "number"
  }]
}

```




## Order Management

- `POST /api/pos/orders` - Create new order

```json
 Request Body: Request Body: {
  "customerId": "string?",
  "items": [{
    "productId": "string",
    "quantity": "number",
    "notes": "string?",
    "modifiers": "array?"
  }],
  "tax": "number",
  "discount": {
    "type": "percentage|fixed",
    "value": "number"
  },
  "paymentMethod": "string",
  "notes": "string?"
}

```


- `PUT /api/pos/orders/{id}` - Update order
- `DELETE /api/pos/orders/{id}` - Cancel order
- `GET /api/pos/orders/active` - Get active orders


## Order Items Operations

- `POST /api/pos/orders/{id}/items` - Add item to order
- `PUT /api/pos/orders/{id}/items/{itemId}` - Update item quantity
- `DELETE /api/pos/orders/{id}/items/{itemId}` - Remove item from order


## Payment Processing

- `POST /api/pos/orders/{id}/payment` - Process payment

```json
 Request Body: Request Body: {
  "method": "CASH|CARD|CREDIT",
  "amount": "number",
  "reference": "string?"
}

```


- `POST /api/pos/orders/{id}/split-payment` - Process split payment

```json
 Request Body: Request Body: {
  "payments": [{
    "method": "string",
    "amount": "number"
  }]
}

```




## Receipt Operations

- `GET /api/pos/orders/{id}/receipt` - Get receipt details
- `POST /api/pos/orders/{id}/receipt/print` - Print receipt
- `POST /api/pos/orders/{id}/receipt/email` - Email receipt

```json
 Request Body: Request Body: {
  "email": "string",
  "format": "PDF|HTML"
}

```




## Customer Management

- `GET /api/pos/customers/search` - Search customers

```json
 Query Parameters: Query Parameters: {
  "query": "string",
  "page": "number",
  "limit": "number"
}

```


- `POST /api/pos/customers` - Create new customer
- `GET /api/pos/customers/{id}/orders` - Get customer order history


## Reporting

- `GET /api/pos/reports/daily` - Get daily sales report

```json
 Query Parameters: Query Parameters: {
  "date": "date",
  "cashier": "string?"
}

```


- `GET /api/pos/reports/sales` - Get sales report

```json
 Query Parameters: Query Parameters: {
  "startDate": "date",
  "endDate": "date",
  "category": "string?",
  "product": "string?"
}

```




## Real-time Operations

- WebSocket endpoint: `ws://api/pos/live`

```json
 Events: Events: {
  "order.created": "OrderData",
  "order.updated": "OrderData",
  "order.completed": "OrderData",
  "stock.updated": "StockData"
}

```




## Data Structures

### Order

```json
 {
  "id": "string",
  "number": "string",
  "status": "PENDING|COMPLETED|CANCELLED",
  "items": [{
    "productId": "string",
    "name": "string",
    "quantity": "number",
    "unitPrice": "number",
    "total": "number",
    "modifiers": "array?"
  }],
  "subtotal": "number",
  "tax": "number",
  "discount": "number",
  "total": "number",
  "paymentStatus": "PENDING|PAID|PARTIALLY_PAID",
  "paymentMethod": "string",
  "customerId": "string?",
  "notes": "string?",
  "createdAt": "datetime",
  "updatedAt": "datetime"
}

```

### Product

```json
 {
  "id": "string",
  "name": "string",
  "categoryId": "string",
  "price": "number",
  "image": "string",
  "inStock": "boolean",
  "modifiers": [{
    "name": "string",
    "options": [{
      "name": "string",
      "price": "number"
    }]
  }]
}

```

## Authentication

All endpoints require a valid JWT token in the Authorization header:
`Authorization: Bearer {token}`

## Error Codes

- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Resource not found
- `409` - Conflict (e.g., insufficient stock)
- `422` - Validation error
- `500` - Internal Server Error


```plaintext

```