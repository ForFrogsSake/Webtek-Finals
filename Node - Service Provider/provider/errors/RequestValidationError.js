module.exports = class extends require('./AppError') {
    constructor (fields) {

      super('Request validation failed', 400);
      
      this.fields = fields || {};
    }
  };