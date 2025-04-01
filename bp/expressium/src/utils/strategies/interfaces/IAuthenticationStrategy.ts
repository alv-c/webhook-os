import { AxiosRequestConfig } from 'axios/index';

/**
 * ## IAuthenticationStrategy
 * 
 * Defines a contract for authentication strategies to implement custom authentication logic.
 * 
 * @description Provides a standardized approach for modifying Axios request configurations 
 * to include authentication credentials or perform authentication-related operations.
 * 
 * @method authenticate - Authenticates the request by modifying its configuration.
 */
export interface IAuthenticationStrategy {
  /**
   * ## authenticate
   * 
   * Authenticates the request by modifying its configuration.
   * 
   * @description This method is responsible for preparing the request configuration 
   * with necessary authentication details. It can perform synchronous or asynchronous 
   * authentication operations, such as adding headers, tokens, or performing 
   * pre-request authentication checks.
   * 
   * @param configurationMap - The Axios request configuration to modify.
   * 
   * @returns The modified request configuration.
   */
  authenticate(configurationMap: AxiosRequestConfig<any>): Promise<AxiosRequestConfig<any>> | AxiosRequestConfig<any>;
}
