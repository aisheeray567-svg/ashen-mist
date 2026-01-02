import { IsString, IsNotEmpty, IsDateString } from 'class-validator';

export class CreateBookingDto {
    @IsNotEmpty()
    @IsString()
    eventId: string;

    @IsNotEmpty()
    @IsString()
    serviceId: string;

    @IsNotEmpty()
    @IsDateString()
    date: string;
}
