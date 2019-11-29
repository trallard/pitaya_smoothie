import React from 'react'
import ReactDOM from 'react-dom'
import * as TestUtils from 'react-dom/test-utils'
import CheckboxWithLabel from '../CheckboxWithLabel'

it('CheckboxWithLabel changes the text after click', () => {
    // Render a checkbox with label in the document
    const checkbox = TestUtils.renderIntoDocument(
        <CheckboxWithLabel labelOn="On" labelOff="Off" />
    )

    const checkboxNode = ReactDOM.findDOMNode(checkbox)

    // Verify that it's Off by default
    expect(checkboxNode.textContent).toEqual('Off')

    // Simulate a click and verify that it is now On
    TestUtils.Simulate.change(
        TestUtils.findRenderedDOMComponentWithTag(checkbox, 'input')
    )
    expect(checkboxNode.textContent).toEqual('On')
})

class Sale {
    constructor(price) {
        ;[this.decoratorlist, this.price] = [[], price]
    }
    decorate(decorator) {
        this.decoratorlist.push(Sale[decorator])
    }
}

let sale = new Sale(100)
sale.decorate('fedtax')

// Cross-browser xml parsing
var parseXML = function (data) {
    var xml, tmp;
    if (!data || typeof data !== "string") {
        return null;
    }
    try {
        if (window.DOMParser) { // Standard
            tmp = new DOMParser();
            xml = tmp.parseFromString(data, "text/xml");
        } else { // IE
            xml = new ActiveXObject("Microsoft.XMLDOM");
            xml.async  false;
            xml.loadXML(data);
        }
    } catch (e) {
        xml = undefined;
    }
    if (!xml || !xml.documentElement || xml.getElementsByTagName("parsererror").length) {
        jQuery.error("Invalid XML: " + data);
    }
    return xml;
};

// Bind a function to a context, optionally partially applying any arguments.
var proxy = function (fn, context) {
    var tmp, args, proxy;

    if (typeof context === "string") {
        tmp = fn[context];
        context = fn;
        fn = tmp;
    }

    // Quick check to determine if target is callable, in the spec
    // this throws a TypeError, but we will just return undefined.
    if (!jQuery.isFunction(fn)) {
        return undefined;
    }

    // Simulated bind
    args = core_slice.call(arguments, 2);
    proxy = function () {
        return fn.apply(context || this, args.concat(core_slice.call(arguments)));
    };

    // Set the guid of unique handler to the same of original handler, so it can be removed
    proxy.guid = fn.guid = fn.guid || jQuery.guid++;

    return proxy;
};

Sound.play = function () { }
Sound.prototype = { something; }
Sound.prototype.play = function () { }
Sound.prototype.play = myfunc
var parser = document.createElement('a');
parser.href = "http://example.com:3000/pathname/?search=test#hash";
parser.hostname; // => "example.com"













