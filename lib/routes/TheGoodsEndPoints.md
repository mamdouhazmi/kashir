# Inventory Management API Endpoints

## Product Management

- `GET /api/products` - Get all products with pagination and filters
  ```json
  Query Parameters: {
    "factory": "string",
    "brand": "string",
    "classification": "string",
    "search": "string",
    "showLowStock": "boolean",
    "showUnused": "boolean",
    "page": "number",
    "limit": "number"
  }
  ```

-`POST /api/products` - Create new product

```json
Request Body: {
 "name": "string",
 "barcode": "string",
 "classification": "string",
 "factory": "string",
 "brand": "string",
 "unit": "string",
 "sellingPrice": "number",
 "discount": "number",
 "minPrice": "number",
 "minQuantity": "number"
    }
```

-`PUT /api/products/{id}` - Update product
-`DELETE /api/products/{id}` - Delete product (with validation check for related invoices)
## Price Management

- `PUT /api/products/prices/single/{id}` - Update single product price

```json
 Request Body: {Request Body: {
  "sellingPrice": "number",
  "discount": "number",
  "minPrice": "number"
}

```


- `PUT /api/products/prices/bulk` - Bulk update prices

```json
 Request Body: {Request Body: {
  "productIds": "array",
  "priceAdjustment": {
    "type": "percentage|fixed",
    "value": "number"
  }
}

```




## Barcode Operations

- `POST /api/products/barcode/print/single/{id}` - Print barcode for single product
- `POST /api/products/barcode/print/bulk` - Print barcodes for multiple products

```json
 Request Body: {Request Body: {
  "productIds": "array",
  "copies": "number"
}

```




## Reports

- `GET /api/reports/products/movement/{id}` - Get product movement report

```json
 Query Parameters: {Query Parameters: {
  "startDate": "date",
  "endDate": "date"
}

```


- `GET /api/reports/inventory` - Get inventory report

```json
 Query Parameters: {Query Parameters: {
  "type": "current|movement",
  "startDate": "date",
  "endDate": "date"
}

```


- `GET /api/reports/products/serial` - Search by serial number

```json
 Query Parameters: {Query Parameters: {
  "serialNumber": "string"
}

```




## Reference Data

- `GET /api/lookup/factories` - Get list of factories
- `GET /api/lookup/brands` - Get list of brands
- `GET /api/lookup/classifications` - Get list of product classifications


## Response Format

All endpoints should return responses in the following format:

```json
 {{
  "success": "boolean",
  "data": "object|array",
  "message": "string",
  "errors": "array"
}

```

## Authentication

All endpoints require a valid JWT token in the Authorization header:
`Authorization: Bearer {token}`

## Error Codes

- `400` - Bad Request (Invalid input)
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Resource not found
- `409` - Conflict (e.g., product has related invoices)
- `500` - Internal Server Error