exports.helloWorld69 = (req, res) => {
    let message = req.query.message || req.body.message || 'Hello World - Clecio!';
    res.status(200).send(message);
  };
  