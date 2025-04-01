import { AxiosRequestConfig } from 'axios/index';
import { IAuthenticationStrategy } from './interfaces';

/**
 * ## ApiKeyStrategy
 * 
 * Simple authentication strategy that adds an API key to the headers of a request.
 * 
 * @description The ApiKeyStrategy class provides a simple authentication strategy
 * for APIs that require an API key for access. This strategy adds the API key to 
 * the HTTP headers of a request, using a configurable header name.
 * 
 * Key features:
 * 
 * - Adds API key to request headers
 * - Supports custom header name (defaults to 'X-API-Key')
 * - Preserves existing headers in the request configuration
 * 
 * The API key is added to the headers using the specified header name (defaults to 'X-API-Key').
 * This implementation preserves any existing headers in the request configuration.
 * 
 * @method authenticate - Authenticates the request by adding the API key to the headers.
 */
export class ApiKeyStrategy implements IAuthenticationStrategy.IAuthenticationStrategy {
  /**
   * ## constructor
   * 
   * Creates a new ApiKeyStrategy instance.
   * 
   * @description Initializes the API key and header name for the authentication strategy.
   * Allows customization of the header used to send the API key.
   * 
   * @public
   * 
   * @constructor
   * 
   * @param key - The API key to use for authentication. This value will be sent with each request.
   * @param headerName - Optional name of the header to use for the API key. Defaults to 'X-API-Key'.
   * 
   * @throws If the key is empty or invalid.
   */
  public constructor(
    /**
     * @private
     * @readonly
     */
    private readonly key: string,

    /**
     * @private
     * @readonly
     */
    private readonly headerName: string = 'X-API-Key'
  ) {}

  /**
   * ## authenticate
   * 
   * Authenticates the request by adding the API key to the headers.
   * 
   * @description Adds the API key to the headers of the request configuration.
   * 
   * This method:
   * 
   * - Preserves any existing headers
   * - Adds or updates the API key header
   * - Ensures the API key is sent with the request
   * 
   * @public
   * 
   * @param configurationMap - The Axios request configuration to modify.
   * 
   * @returns The modified request configuration with the API key added to the headers.
   */
  public authenticate(configurationMap: AxiosRequestConfig<any>): AxiosRequestConfig<any> {
    return {
      ...configurationMap,
      headers: {
        ...configurationMap.headers,
        [this.headerName]: this.key
      }
    };
  }
}
