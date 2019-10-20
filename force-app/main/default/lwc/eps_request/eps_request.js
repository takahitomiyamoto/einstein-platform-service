/* eslint-disable no-console */
import {LightningElement, api, track, wire} from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';
import {fireEvent} from 'c/pubsub2';

export default class EPS_Request extends LightningElement {
  httpMethod = {
    label: 'Method'
  };
  httpEndpoint = {
    label: 'Endpoint'
  };
  httpDatasetId = {
    label: 'Dataset ID'
  };
  httpModelId = {
    label: 'Model ID'
  };
  httpAuthorization = {
    label: 'Authorization'
  };
  httpCacheControl = {
    label: 'Cache Control'
  };
  httpContentType = {
    label: 'Content-Type'
  };
  httpData = {
    label: 'data'
  };
  httpLanguage = {
    label: 'language'
  };
  httpName = {
    label: 'name'
  };
  httpPath = {
    label: 'path'
  };
  httpType = {
    label: 'path'
  };

  @api pubCustomEventName = '';

  @track httpMethodValue = '';
  @track httpEndpointValue = '';
  @track httpDatasetIdValue = '';
  @track httpDatasetIdBodyValue = '';
  @track httpModelIdValue = '';
  @track httpAuthorizationValue = 'Bearer ';
  @track httpCacheControlValue = '';
  @track httpContentTypeValue = '';
  @track httpDataValue = '';
  @track httpLanguageValue = '';
  @track httpNameValue = '';
  @track httpPathValue = '';
  @track httpTypeValue = '';

  @wire(CurrentPageReference) pageRef;

  get httpMethodOptions() {
    return [
      {label: '-----', value: ''},
      {label: 'GET', value: 'GET'},
      {label: 'POST', value: 'POST'},
      {label: 'PUT', value: 'PUT'}
    ];
  }
  get httpEndpointOptions() {
    return [
      {label: '-----', value: ''},
      {
        label: '[GET] /v2/language/datasets',
        value: 'https://api.einstein.ai/v2/language/datasets'
      },
      {
        label: '[GET] /v2/language/datasets/<DATASET_ID>',
        value: 'https://api.einstein.ai/v2/language/datasets/_DATASET_ID'
      },
      {
        label: '[GET] /v2/language/datasets/<DATASET_ID>/models',
        value: 'https://api.einstein.ai/v2/language/datasets/_DATASET_ID/models'
      },
      {
        label: '[GET] /v2/language/models/<MODEL_ID>',
        value: 'https://api.einstein.ai/v2/language/models/_MODEL_ID'
      },
      {
        label: '[GET] /v2/language/train/<MODEL_ID>',
        value: 'https://api.einstein.ai/v2/language/train/_MODEL_ID'
      },
      {
        label: '[POST] /v2/language/datasets/upload',
        value: 'https://api.einstein.ai/v2/language/datasets/upload'
      },
      {
        label: '[POST] /v2/language/datasets/upload/sync',
        value: 'https://api.einstein.ai/v2/language/datasets/upload/sync'
      },
      {
        label: '[POST] /v2/language/train',
        value: 'https://api.einstein.ai/v2/language/train'
      },
      {
        label: '[POST] /v2/language/retrain',
        value: 'https://api.einstein.ai/v2/language/retrain'
      },
      {
        label: '[PUT] /v2/language/datasets/<DATASET_ID>/upload',
        value: 'https://api.einstein.ai/v2/language/datasets/_DATASET_ID/upload'
      },
      {
        label: '[GET] /v2/vision/datasets/<DATASET_ID>/models',
        value: 'https://api.einstein.ai/v2/vision/datasets/_DATASET_ID/models'
      },
      {
        label: '[GET] /v2/vision/models/<MODEL_ID>',
        value: 'https://api.einstein.ai/v2/vision/models/_MODEL_ID'
      },
      {
        label: '[GET] /v2/vision/train/<MODEL_ID>',
        value: 'https://api.einstein.ai/v2/vision/train/_MODEL_ID'
      },
      {
        label: '[POST] /v2/vision/train',
        value: 'https://api.einstein.ai/v2/vision/train'
      },
      {
        label: '[POST] /v2/vision/retrain',
        value: 'https://api.einstein.ai/v2/vision/retrain'
      }
    ];
  }
  get httpCacheControlOptions() {
    return [
      {label: '-----', value: ''},
      {label: 'no-cache', value: 'no-cache'}
    ];
  }
  get httpContentTypeOptions() {
    return [
      {label: '-----', value: ''},
      {label: 'application/json', value: 'application/json'}
    ];
  }
  get httpLanguageOptions() {
    return [{label: '-----', value: ''}, {label: 'en_US', value: 'en_US'}];
  }
  get httpTypeOptions() {
    return [
      {label: '-----', value: ''},
      {label: 'intent', value: 'text-intent'},
      {label: 'sentiment', value: 'text-sentiment'}
    ];
  }

  handleHttpMethodOptionChange(event) {
    this.httpMethodValue = event.target.value;
  }
  handleHttpEndpointChange(event) {
    console.log('handleHttpEndpointChange');
    this.httpEndpointValue = event.target.value;
    console.log(this.httpEndpointValue);
  }
  handleHttpDatasetIdChange(event) {
    this.httpDatasetIdValue = event.target.value;
  }
  handleHttpDatasetIdBodyChange(event) {
    this.httpDatasetIdBodyValue = event.target.value;
  }
  handleHttpModelIdChange(event) {
    this.httpModelIdValue = event.target.value;
  }
  handleHttpAuthorizationChange(event) {
    this.httpAuthorizationValue = event.target.value;
  }
  handleHttpCacheControlChange(event) {
    this.httpCacheControlValue = event.target.value;
  }
  handleHttpContentTypeChange(event) {
    this.httpContentTypeValue = event.target.value;
  }
  handleHttpDataChange(event) {
    this.httpDataValue = event.target.value;
  }
  handleHttpLanguageChange(event) {
    this.httpLanguageValue = event.target.value;
  }
  handleHttpNameChange(event) {
    this.httpNameValue = event.target.value;
  }
  handleHttpPathChange(event) {
    this.httpPathValue = event.target.value;
  }
  handleHttpTypeChange(event) {
    this.httpTypeValue = event.target.value;
  }

  handleSend() {
    console.log('handleSend');
    const httpEndpointValueCached = this.httpEndpointValue;
    this.httpEndpointValue = this.httpEndpointValue.replace(
      '_DATASET_ID',
      this.httpDatasetIdValue
    );
    this.httpEndpointValue = this.httpEndpointValue.replace(
      '_MODEL_ID',
      this.httpModelIdValue
    );

    const params = {
      method: this.httpMethodValue,
      endpoint: this.httpEndpointValue,
      header: {
        authorization: this.httpAuthorizationValue,
        cacheControl: this.httpCacheControlValue,
        contentType: this.httpContentTypeValue
      },
      body: {}
    };
    fireEvent(this.pageRef, this.pubCustomEventName, JSON.stringify(params));
    this.httpEndpointValue = httpEndpointValueCached;
  }
}
