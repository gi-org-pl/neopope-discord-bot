import { Module } from '@nestjs/common';
import { AppService } from './service/app.service';
import { AppCommands } from './service/app.commands';

@Module({
  providers: [AppService, AppCommands],
})
export class PopeModule {}
