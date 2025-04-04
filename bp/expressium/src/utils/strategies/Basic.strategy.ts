import { AxiosRequestConfig } from 'axios/index';
import { IAuthenticationStrategy } from './interfaces';

/**
 * ## BasicStrategy
 * 
 * Simple authentication strategy that adds basic credentials to the request configuration.
 * 
 * @description The BasicStrategy class provides a straightforward authentication strategy
 * for APIs that require basic authentication (username and password).
 * 
 * Key features:
 * 
 * - Adds username and password to request configuration
 * - Automatically generates base64-encoded Authorization header
 * - Leverages Axios built-in basic authentication handling
 * 
 * When this strategy is applied, the username and password are added to the request
 * configuration's 'auth' property. Axios will automatically generate the appropriate
 * Authorization header with the base64-encoded credentials.
 * 
 * @method authenticate - Authenticates the request by adding basic credentials to the configuration.
 */
export class BasicStrategy implements IAuthenticationStrategy.IAuthenticationStrategy {
  /**
   * ## constructor
   * 
   * Creates a new BasicStrategy instance.
   * 
   * @description Initializes the username and password for basic authentication credentials.
   * These credentials will be used to generate the appropriate Authorization header.
   * 
   * @public
   * 
   * @constructor
   * 
   * @param username - The username for basic authentication. This value will be encoded in the Authorization header.
   * @param password - The password for basic authentication. This value will be encoded in the Authorization header.
   * 
   * @throws If username or password are invalid or empty.
   */
  public constructor(
    /**
     * @private
     * @readonly
     */
    private readonly username: string,

    /**
     * @private
     * @readonly
     */
    private readonly password: string
  ) {}

  /**
   * ## authenticate
   * 
   * Authenticates the request by adding basic credentials to the configuration.
   * 
   * @description Adds the basic credentials to the request configuration's 'auth' property.
   * Axios will automatically generate the appropriate Authorization header with 
   * base64-encoded credentials in the format 'Basic {base64(username:password)}'.
   * 
   * @public
   * 
   * @param configurationMap - The Axios request configuration to modify.
   * 
   * @returns The modified request configuration with the basic credentials added.
   */
  public authenticate(configurationMap: AxiosRequestConfig<any>): AxiosRequestConfig<any> {
    return {
      ...configurationMap,
      auth: {
        username: this.username,
        password: this.password
      }
    };
  }
}
