import { Request, Response, NextFunction } from "express";

interface CustomRequest extends Request {
    user?: {
        id: number;
        company?: {
            id: number;
            name: string;
        };
    };
}
import { AppDataSource } from '../../../config/data-source'; // Adjust path as necessary
import { User } from '../../user/models/user.model';
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { ModuleIcon } from "../../module/models/module_icon.model";
import { SubModule } from "../../module/models/sub_module.model";
import { ModuleGroup } from "../../module/models/module_group.model";
import { Module } from '../../module/models/module.model';

export const rbac = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
        const customReq = req as CustomRequest;
        const userId = customReq?.user?.id;
        const UserRepository = AppDataSource.getRepository(User);
        const userDetails = await UserRepository.findOneBy({ id: userId });
        const companyId = customReq?.user?.company?.id;
        if (userDetails?.customized_permissions === 'enable') {

        } else {
            const query = `
                SELECT 
                    mg.group_name,
                    m.id AS module_id, 
                    m.module_name, 
                    m.key AS module_key, 
                    m.description AS module_description, 
                    mi_module.icon_name AS module_icon, 
                    sm.id AS sub_module_id, 
                    sm.sub_module_name, 
                    sm.description AS sub_module_description, 
                    mi_submodule.icon_name AS sub_module_icon, 
                    sm.key AS sub_module_key
                FROM module_groups mg
                LEFT JOIN modules m ON mg.id = m.module_group_id
                LEFT JOIN module_icons mi_module ON m.module_icon_id = mi_module.id
                LEFT JOIN sub_modules sm ON m.id = sm.module_id
                LEFT JOIN module_icons mi_submodule ON sm.module_icon_id = mi_submodule.id
                WHERE mg.status = 'active'
                AND m.status = 'active'
                AND sm.status = 'active'
                AND m.company_id = ${companyId}
                AND sm.company_id = ${companyId}
                AND mg.company_id = ${companyId}
                ORDER BY mg.id ASC, m.id ASC, sm.id ASC;
            `;

            const result = await AppDataSource.query(query); // Execute raw query

            res.status(200).json({
                status: true,
                message: "Role-Based Access Control Data",
                data: result,
            });
        }



        res.status(200).json({
            status: true,
            message: "Role-Based Access Control Data",
            data: 'result',
        });
    } catch (error) {
        const stackTrace = (error instanceof Error && error.stack) ? error.stack.split("\n")[1].trim() : "Unknown";

        res.status(500).json({
            status: false,
            message: "Internal Server Error",
            error: error instanceof Error ? error.message : "Unknown error",
            filePath: __filename, // Gets current file path
            lineNumber: stackTrace, // Extracts line number from stack trace
        });
    }

}
