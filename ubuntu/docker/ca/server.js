// 2014 Jon Suderman
// https://github.com/suderman/local
// 
// Simple Certificate Authority API
// Port 11443
// GET to build/request certificates
// POST to revoke/delete certificates
//
// OCSP responder
// Port 11188
// GET or POST OCSP queries

require('shelljs/global');
var express = require('express'),
    ocsp = express(),
    ocsp_server = require('http').createServer(ocsp);


// ----------------------
// Private App
// ----------------------
var app = express(),
    server = require('http').createServer(app);

// Where to find views
app.configure(function() {
  app.set('views', __dirname);
});

// Send the root certificate
app.get('/ca.crt', function(req, res) {
  res.sendfile('/config/ca/ca.crt');
});

// Send the certificate revocation list
app.get('/ca.crl', function(req, res) {
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

// Private port
port = 11443;
app.listen(port);
console.log('Listening on port ' + port);



// ----------------------
//  Public App
// ----------------------
var public_app = express(),
    public_server = require('http').createServer(public_app);

// Where to find views
public_app.configure(function() {
  public_app.set('views', __dirname);
});

// Send the root certificate
public_app.get('/ca.crt', function(req, res) {
  res.sendfile('/config/ca/ca.crt');
});

// Send the certificate revocation list
public_app.get('/ca.crl', function(req, res) {
  res.sendfile('/config/crl/ca.crl');
});

// Show index page
public_app.get(/\/*/, function(req, res) {
  var ca_name = (test('-f', '/config/env/CA_NAME')) ? exec('cat /config/env/CA_NAME', { encoding: 'utf8', silent:true }).output : "Certificate Authority";
  var domain = (test('-f', '/config/env/DOMAIN')) ? exec('cat /config/env/DOMAIN', { encoding: 'utf8', silent:true }).output : "localhost";
  res.render('index.ejs', { private: false, certs: [], ca_name: ca_name, ca_email: 'ca@' + domain  });
});

// Public port
port = 11180;
public_app.listen(port);
console.log('Listening on port ' + port);


// ----------------------
// OCSP Responder
// ----------------------
var ocsp = express(),
    ocsp_server = require('http').createServer(ocsp),
    fs = require('fs'),
    findRemoveSync = require('find-remove');

// Needed for req.rawBody
ocsp.configure(function() {
  ocsp.use(function(req, res, next) {
    var data = new Buffer('');
    req.on('data', function(chunk) {
        data = Buffer.concat([data, chunk]);
    });
    req.on('end', function() {
      req.rawBody = data;
      next();
    });
  });
});

// Verify this certificate
ocsp.verify = function(b64, res) {

  // Get path from b64
  var path = '/config/responses/' + require('querystring').escape(b64.replace(/\//g,'-')).substring(0,15);

  // Remove old responses
  findRemoveSync('/config/responses', {age: {seconds: 300}});

  // Decode b64 string to request file if none exists
  if (!test('-f', path + '.req')) {
    fs.writeFileSync(path + '.req', new Buffer(b64, 'base64'));
  }

  // Generate a new response if none exists
  if (!test('-f', path)) {
    exec("/ocsp.sh '" + path + "'", { encoding: 'utf8' });
  }

  // Send the response
  if (test('-f', path)) {
    res.sendfile(path);
  } else {
    res.send(200, '');
  }
}

// Verify request on POST
ocsp.post('/', function(req, res) {
  var b64 = new Buffer(req.rawBody).toString('base64')
  res.setHeader('content-type', 'application/ocsp-response');
  ocsp.verify(b64, res);
});

// Verify request on GET
ocsp.get('/:request', function(req, res) {
  var b64 = unescape(req.params.request);
  res.setHeader('content-type', 'application/ocsp-response');
  ocsp.verify(b64, res);
});

// Nothing on GET index page
ocsp.get('/', function(req, res) {
  res.setHeader('content-type', 'application/ocsp-response');
  res.send(200, '');
});

// OCSP port
port = 11188;
ocsp.listen(port);
console.log('Listening on port ' + port);
