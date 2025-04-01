import { NextFunction, Request, Response } from 'express';
import { generateRoute, router, IRouteMap, dateTimeFormatterUtil } from '../../expressium/src';
import { appService, main } from "../services";

export const buildRoutes = (): void => {
  try {
    generateRoute(
      {
        method: 'post',
        version: 'v1',
        url: 'webhook',
        serviceHandler: main.main,
        requiresAuthorization: false
      } as IRouteMap.IRouteMap
    );

    router.use(
      (
        req: Request, 
        res: Response, 
        _next: NextFunction
      ): void => {
        res
          .status(404)
          .json(
            {
              timestamp: dateTimeFormatterUtil.formatAsDayMonthYearHoursMinutesSeconds(new Date()),
              status: false,
              statusCode: 404,
              method: req.method,
              path: req.originalUrl || req.url,
              query: req.query,
              body: req.body,
              message: 'Route not found.',
              suggestion: 'Please check the URL and HTTP method to ensure they are correct.'
            }
          );
      }
    );
  } catch (error: unknown) {
    console.log(`Route | Timestamp: ${ dateTimeFormatterUtil.formatAsDayMonthYearHoursMinutesSeconds(new Date()) } | Name: generateRoutes | Error: ${ error instanceof Error ? error.message : String(error) }`);
    process.exit(1);
  }
};
