module.exports = class EmailTakenError extends require('./AppError') {
    constructor(message) {
        super(message || 'Specified E-mail is already taken', 400);
    }
}