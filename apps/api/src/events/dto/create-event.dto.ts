import { IsString, IsNotEmpty, IsDateString, IsOptional } from 'class-validator';

export class CreateEventDto {
    @IsNotEmpty()
    @IsString()
    title: string;

    @IsOptional()
    @IsString()
    description?: string;

    @IsNotEmpty()
    @IsDateString()
    date: string;

    @IsOptional()
    @IsString()
    location?: string;
}
