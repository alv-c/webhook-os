export interface IResponseData {
  timestamp: string;
  status: boolean;
  statusCode: number;
  method: string;
  path: string;
  query: Record<string, any>;
  headers: Record<string, any>;
  body: any;
  message: string;
  suggestion: string;
}
