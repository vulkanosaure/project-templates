//import jsdom from 'jsdom';
import chai from 'chai';
import chaiImmutable from 'chai-immutable';

const jsdom = require("jsdom");
const { JSDOM } = jsdom;

/*
const doc = jsdom.jsdom('<!doctype html><html><body></body></html>');
const win = doc.defaultView;
*/
const dom = new JSDOM(`<!DOCTYPE html><html><body></body></html>`);
const doc = dom.window.document;
const win = dom.window;

global.document = doc;
global.window = win;

Object.keys(window).forEach((key) => {
  if (!(key in global)) {
    global[key] = window[key];
  }
});

chai.use(chaiImmutable);