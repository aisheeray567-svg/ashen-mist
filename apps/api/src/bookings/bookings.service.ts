import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateBookingDto } from './dto/create-booking.dto';
import { BookingStatus } from '@repo/database';

@Injectable()
export class BookingsService {
    constructor(private prisma: PrismaService) { }

    async create(userId: string, createBookingDto: CreateBookingDto) {
        return this.prisma.booking.create({
            data: {
                ...createBookingDto,
                userId,
                status: BookingStatus.PENDING,
                date: new Date(createBookingDto.date), // Ensure date is Date object
            },
        });
    }

    async findAll(userId: string) {
        return this.prisma.booking.findMany({
            where: { userId },
            include: {
                event: true,
                service: true,
            },
        });
    }

    async updateStatus(id: string, status: BookingStatus) {
        return this.prisma.booking.update({
            where: { id },
            data: { status },
        });
    }
}
