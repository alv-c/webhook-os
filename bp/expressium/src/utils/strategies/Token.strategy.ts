import { AxiosRequestConfig } from 'axios/index';
import { IAuthenticationStrategy } from './interfaces';

/**
 * ## TokenStrategy
 * 
 * Simple authentication strategy that adds a token to the headers of a request.
 * 
 * @description The TokenStrategy class provides a simple authentication strategy
 * for APIs that require token-based access, such as OAuth 2.0 or JWT authentication systems.
 * 
 * Key features:
 * 
 * - Adds token to Authorization header
 * - Uses 'Bearer' token prefix as per OAuth 2.0 specification
 * - Preserves existing headers in the request configuration
 * 
 * @method authenticate - Authenticates the request by adding the token to the headers.
 */
export class TokenStrategy implements IAuthenticationStrategy.IAuthenticationStrategy {
  /**
   * ## constructor
   * 
   * Creates a new TokenStrategy instance.
   * 
   * @description Initializes the token for authentication.
   * This token will be used to generate the Authorization header.
   * 
   * @public
   * 
   * @constructor
   * 
   * @param token - The token to use for authentication. This value will be sent with each request.
   * 
   * @throws If the token is empty or invalid.
   */
  public constructor(
    /**
     * @private
     * @readonly
     */
    private readonly token: string
  ) {}

  /**
   * ## authenticate
   * 
   * Authenticates the request by adding the token to the headers.
   * 
   * @description Adds the token to the Authorization header of the request configuration.
   * The token is prefixed with 'Bearer ' as per the OAuth 2.0 specification.
   * This method preserves any existing headers and only adds or updates the Authorization header.
   * 
   * @public
   * 
   * @param configurationMap - The Axios request configuration to modify.
   * 
   * @returns The modified request configuration with the token added to the Authorization header.
   */
  public authenticate(configurationMap: AxiosRequestConfig<any>): AxiosRequestConfig<any> {
    return {
      ...configurationMap,
      headers: {
        ...configurationMap.headers,
        Authorization: `Bearer ${ this.token }`
      }
    };
  }
}
