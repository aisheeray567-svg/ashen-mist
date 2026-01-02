import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateEventDto } from './dto/create-event.dto';

@Injectable()
export class EventsService {
    constructor(private prisma: PrismaService) { }

    async create(userId: string, createEventDto: CreateEventDto) {
        return this.prisma.event.create({
            data: {
                ...createEventDto,
                userId,
            },
        });
    }

    async findAll() {
        return this.prisma.event.findMany({
            include: {
                user: { select: { email: true } },
            },
        });
    }

    async findOne(id: string) {
        const event = await this.prisma.event.findUnique({
            where: { id },
            include: {
                bookings: true,
            },
        });
        if (!event) {
            throw new NotFoundException('Event not found');
        }
        return event;
    }
}
