/* eslint-disable no-console */
import {LightningElement, api, track, wire} from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import {loadStyle} from 'lightning/platformResourceLoader';
import eps_responseStyle from '@salesforce/resourceUrl/eps_responseStyle';
import {registerListener, unregisterAllListeners} from 'c/pubsub2';
import sendHttpRequest from '@salesforce/apex/EPS_HttpClient.sendHttpRequest';

export default class HelloWorld3 extends LightningElement {
  httpResponse = {
    label: 'Response (JSON)'
  };

  @api subCustomEventName = '';

  @track httpResponseValue = '{}';
  @track httpRequest = '';
  @track httpRequestOld = '';

  @wire(CurrentPageReference) pageRef;
  @wire(sendHttpRequest, {
    httpRequest: '$httpRequest'
  })
  getHttpResponse({error, data}) {
    if (error) {
      console.log(error);
    }
    if (data) {
      const pretty = JSON.stringify(JSON.parse(data), null, 2);
      this.handleHttpResponseChange(pretty);
    }
    // this.handleHttpRequestChange('');
  }

  connectedCallback() {
    console.log('connectedCallback');
    Promise.all([loadStyle(this, eps_responseStyle + '/style.css')]);
    registerListener(
      this.subCustomEventName,
      this.handleHttpRequestChange,
      this
    );
  }
  disconnectedCallback() {
    console.log('disconnectedCallback');
    unregisterAllListeners(this);
  }

  handleClear() {
    console.log('handleClear');
    this.handleHttpResponseChange('');
  }
  handleHttpRequestChange(httpRequest) {
    console.log('handleHttpRequestChange');
    if (this.httpRequestOld === httpRequest) {
      this.httpRequest = '';
    } else {
      this.httpRequest = httpRequest;
    }
    this.httpRequestOld = this.httpRequest;
  }
  handleHttpResponseChange(value) {
    console.log('handleHttpResponseChange');
    this.httpResponseValue = value;
  }
}
