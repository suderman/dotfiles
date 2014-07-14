// 2014 Jon Suderman
// https://github.com/suderman/local
// 
// Simple Certificate Authority API
// GET to build/request certificates
// POST to revoke/delete certificates

require('shelljs/global');
var express = require('express'),
    app = express(),
    public_app = express(),
    server = require('http').createServer(app);
    public_server = require('http').createServer(public_app);

// Where to find views
app.configure(function() {
  app.set('views', __dirname);
});
public_app.configure(function() {
  public_app.set('views', __dirname);
});


// Send the root certificate
app.get('/ca.crt', function(req, res) {
  res.sendfile('/config/ca/ca.crt');
});
public_app.get('/ca.crt', function(req, res) {
  res.sendfile('/config/ca/ca.crt');
});


// Send the certificate revocation list
app.get('/ca.crl', function(req, res) {
  res.sendfile('/config/crl/ca.crl');
});
public_app.get('/ca.crl', function(req, res) {
  res.sendfile('/config/crl/ca.crl');
});


// Sign/present certificates on GET
app.get('/:filename\.:filetype(crt|key|p12|pub|zip)', function(req, res) {
  var path = '/config/certs/' + req.params.filename + '/' + req.params.filename + '.' + req.params.filetype;

  // Build the requested file if it doesn't exist
  if (!test('-f', path)) {
    exec("/certify.sh '" + req.params.filename + "'", { encoding: 'utf8' });
  }

  // Send the requested file
  res.sendfile(path);
});


// Revoke certicates on POST
app.post('/:filename\.:filetype(crt|key|p12|pub|zip)', function(req, res) {
  var path = '/config/certs/' + req.params.filename + '/' + req.params.filename + '.' + req.params.filetype;

  // Revoke the certificate if it exists
  if (test('-f', path)) {
    exec("/revoke.sh '" + req.params.filename + "'", { encoding: 'utf8' });
    res.send(200, req.params.filename + ' is now revoked');
  } else {
    res.send(200, req.params.filename + " doesn't exist");
  }
});


// Show index page
app.get(/\/*/, function(req, res) {
  var certs = exec('ls /config/certs', { encoding: 'utf8', silent:true }).output.split("\n");
  var ca_name = (test('-f', '/config/env/CA_NAME')) ? exec('cat /config/env/CA_NAME', { encoding: 'utf8', silent:true }).output : "Certificate Authority";
  var domain = (test('-f', '/config/env/DOMAIN')) ? exec('cat /config/env/DOMAIN', { encoding: 'utf8', silent:true }).output : "localhost";
  res.render('index.ejs', { private: true, certs: certs, ca_name: ca_name, ca_email: 'ca@' + domain });
});
public_app.get(/\/*/, function(req, res) {
  var ca_name = (test('-f', '/config/env/CA_NAME')) ? exec('cat /config/env/CA_NAME', { encoding: 'utf8', silent:true }).output : "Certificate Authority";
  var domain = (test('-f', '/config/env/DOMAIN')) ? exec('cat /config/env/DOMAIN', { encoding: 'utf8', silent:true }).output : "localhost";
  res.render('index.ejs', { private: false, certs: [], ca_name: ca_name, ca_email: 'ca@' + domain  });
});


// Private port
port = 11443;
app.listen(port);
console.log('Listening on port ' + port);

// Public port
port = 11180;
public_app.listen(port);
console.log('Listening on port ' + port);
