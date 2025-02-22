const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 4050;

app.use(bodyParser.json());

let orders = [
  {
    id: 1,
    petId: 198772,
    quantity: 7,
    shipDate: '2077-08-24T14:15:22Z',
    status: 'approved',
    complete: true,
  },
];

app.patch('/store/order', (req, res) => {
  const { id, petId, quantity, shipDate, status, complete } = req.body;
  const orderIndex = orders.findIndex((order) => order.id === id);

  if (orderIndex > -1) {
    const updatedOrder = { ...orders[orderIndex], petId, quantity, shipDate, status, complete };
    orders[orderIndex] = updatedOrder;
    res.json(updatedOrder);
  } else {
    res.status(404).send('Order not found');
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
