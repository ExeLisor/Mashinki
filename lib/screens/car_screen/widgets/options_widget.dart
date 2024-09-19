import 'package:autoverse/exports.dart';

class OptionsWidget extends StatelessWidget {
  OptionsWidget({super.key});

  final CarOptions options =
      CarController.to.car.selectedModification.carOptions ?? CarOptions();

  @override
  Widget build(BuildContext context) => Obx(() {
        final Modification modification =
            CarController.to.car.selectedModification;
        if (modification.isLoading) return const CircularProgressIndicator();
        return Container(
          color: Colors.white,
          width: Get.width,
          padding:
              EdgeInsets.only(left: 25.w, top: 30.h, bottom: 25.h, right: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _modificationTitle(),
              DropSpecsBlockWidget(title: "Материалы", specs: _materials()),
              DropSpecsBlockWidget(title: "Сиденья", specs: _salon()),
              DropSpecsBlockWidget(
                  title: "Салон", specs: _internalCharacteristics()),
              DropSpecsBlockWidget(
                  title: "Крыша и окна", specs: _roofAndWindow()),
              DropSpecsBlockWidget(
                  title: "Зеркала и камеры", specs: _mirrors()),
              DropSpecsBlockWidget(title: "Освещение", specs: _lighting()),
              DropSpecsBlockWidget(title: "Климат", specs: _climate()),
              DropSpecsBlockWidget(title: "Системы помощи", specs: _parking()),
              DropSpecsBlockWidget(title: "Доп. удобства", specs: _features()),
              DropSpecsBlockWidget(title: "Безопасность", specs: _safe()),
              DropSpecsBlockWidget(title: "Стабильность", specs: _stability()),
              DropSpecsBlockWidget(title: "Ассистенты", specs: _assistents()),
              DropSpecsBlockWidget(title: "Охрана", specs: _security()),
              DropSpecsBlockWidget(title: "Мультимедиа", specs: _audio()),
              DropSpecsBlockWidget(
                  title: "Навигация и связь", specs: _navigation()),
              DropSpecsBlockWidget(title: "Колеса", specs: _wheels()),
              DropSpecsBlockWidget(title: "Подвеска", specs: _control()),
              DropSpecsBlockWidget(title: "Кузов и стиль", specs: _style()),
            ],
          ),
        );
      });

  Widget _modificationTitle() {
    Modification modification = CarController.to.car.selectedModification;
    CarSpecifications specification = modification.carSpecifications!;
    String transmission = getTransmissionAbb(specification.transmission);

    int? power = specification.horsePower;
    double? volume = specification.volumeLitres;
    String privod = specification.drive == "полный" ? "4WD" : "";
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Text(
        "${CarController.to.car.selectedModification.groupName ?? ""} ${volume == 0 ? "" : volume} $transmission ${power == 0 ? "" : power} $privod",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _style() => [
        {"Обвес": getValue(options.bodyKit)},
        {"Молдинги": getValue(options.bodyMouldings)},
        {"Двухцветный кузов": getValue(options.duoBodyColor)},
        {"Металлическая краска": getValue(options.paintMetallic)},
        {"Рейлинги": getValue(options.roofRails)},
      ];

  List<Map<String, dynamic>> _control() => [
        {"Активная подвеска": getValue(options.activSuspension)},
        {"Пневмоподвеска": getValue(options.airSuspension)},
        {"Спортивная подвеска": getValue(options.sportSuspension)},
      ];

  List<Map<String, dynamic>> _wheels() => [
        {"Запасное колесо": getValue(options.spareWheel)},
        {"Уменьшенное запасное колесо": getValue(options.reduceSpareWheel)},
        {"14 дюймовые колеса": getValue(options.wheel14Inch)},
        {"15 дюймовые колеса": getValue(options.wheel15Inch)},
        {"16 дюймовые колеса": getValue(options.wheel16Inch)},
        {"17 дюймовые колеса": getValue(options.wheel17Inch)},
        {"18 дюймовые колеса": getValue(options.wheel18Inch)},
        {"19 дюймовые колеса": getValue(options.wheel19Inch)},
        {"20 дюймовые колеса": getValue(options.wheel20Inch)},
        {"21 дюймовые колеса": getValue(options.wheel21Inch)},
        {"22 дюймовые колеса": getValue(options.wheel22Inch)},
        {"Стальные колеса": getValue(options.steelWheels)},
      ];

  List<Map<String, dynamic>> _navigation() => [
        {"Навигационная система": getValue(options.navigation)},
        {"Распознавание голоса": getValue(options.voiceRecognition)},
        {"Android Auto": getValue(options.androidAuto)},
        {"Apple CarPlay": getValue(options.appleCarplay)},
      ];

  List<Map<String, dynamic>> _security() => [
        {"Сигнализация": getValue(options.alarm)},
        {"Иммобилайзер": getValue(options.immo)},
        {"Центральный замок": getValue(options.lock)},
        {"Датчик объема": getValue(options.volumeSensor)},
        {"Система обратной связи": getValue(options.feedbackAlarm)},
        {"Ламинированные стекла": getValue(options.laminatedSafetyGlass)},
      ];

  List<Map<String, dynamic>> _audio() => [
        {"Подготовка для аудиосистемы": getValue(options.audiopreparation)},
        {"Аудиосистема с CD": getValue(options.audiosystemCd)},
        {"Аудиосистема с TV": getValue(options.audiosystemTv)},
        {"Bluetooth": getValue(options.bluetooth)},
        {"AUX": getValue(options.aux)},
        {"Премиум аудиосистема": getValue(options.musicSuper)},
        {"USB": getValue(options.usb)},
      ];

  List<Map<String, dynamic>> _assistents() => [
        {"Мониторинг слепых зон": getValue(options.blindSpot)},
        {
          "Система предупреждения усталости водителя":
              getValue(options.drowsyDriverAlertSystem)
        },
        {"Ассистент удержания полосы": getValue(options.laneKeepingAssist)},
        {"Ночное видение": getValue(options.nightVision)},
        {
          "Электронная блокировка задних дверей":
              getValue(options.powerChildLocksRearDoors)
        },
        {
          "Распознавание дорожных знаков":
              getValue(options.trafficSignRecognition)
        },
        {"Система контроля давления в шинах": getValue(options.tyrePressure)},
        {"ГЛОНАСС": getValue(options.glonass)},
      ];

  List<Map<String, dynamic>> _stability() => [
        {"ABS": getValue(options.abs)},
        {"Антипробуксовочная система ASR": getValue(options.asr)},
        {"Усилитель экстренного торможения BAS": getValue(options.bas)},
        {"Система стабилизации ESP": getValue(options.esp)},
        {"Система управления устойчивостью VSM": getValue(options.vsm)},
        {
          "Ассистент предотвращения столкновений":
              getValue(options.collisionPreventionAssist)
        },
        {"Система помощи при спуске HCC": getValue(options.hcc)},
      ];

  List<Map<String, dynamic>> _safe() => [
        {"Шторки безопасности": getValue(options.airbagCurtain)},
        {"Подушка безопасности водителя": getValue(options.airbagDriver)},
        {"Подушка безопасности пассажира": getValue(options.airbagPassenger)},
        {
          "Задние боковые подушки безопасности":
              getValue(options.airbagRearSide)
        },
        {"Боковые подушки безопасности": getValue(options.airbagSide)},
        {"Подушка безопасности для коленей": getValue(options.kneeAirbag)},
        {"Крепления ISOFIX": getValue(options.isofix)},
        {"ISOFIX на переднем сиденье": getValue(options.isofixFront)},
      ];

  List<Map<String, dynamic>> _features() => [
        {
          "Пепельница и прикуриватель":
              getValue(options.ashtrayAndCigaretteLighter)
        },
        {"Легкое открытие багажника": getValue(options.easyTrunkOpening)},
        {"Электропривод багажника": getValue(options.electroTrunk)},
        {"Электростеклоподъемники задние": getValue(options.electroWindowBack)},
        {
          "Электростеклоподъемники передние":
              getValue(options.electroWindowFront)
        },
        {"Электронная приборная панель": getValue(options.electronicGagePanel)},
        {"Бортовой компьютер": getValue(options.computer)},
        {"Сервопривод": getValue(options.servo)},
        {
          "Программируемый предпусковой подогреватель":
              getValue(options.programmedBlockHeater)
        },
        {"Проекционный дисплей": getValue(options.projectionDisplay)},
        {"Охлаждаемый бокс": getValue(options.coolingBox)},
        {"Розетка 12В": getValue(options.socket12V)},
        {"Розетка 220В": getValue(options.socket220V)},
        {"Беспроводная зарядка": getValue(options.wirelessCharger)},
      ];

  List<Map<String, dynamic>> _parking() => [
        {"Автопилот": getValue(options.autoCruise)},
        {"Автопарковка": getValue(options.autoPark)},
        {"Система выбора режима вождения": getValue(options.driveModeSys)},
        {"Передний парктроник": getValue(options.parkAssistF)},
        {"Задний парктроник": getValue(options.parkAssistR)},
        {"Бесключевой доступ": getValue(options.keylessEntry)},
        {"Дистанционный запуск двигателя": getValue(options.remoteEngineStart)},
        {"Кнопка запуска": getValue(options.startButton)},
        {"Система старт-стоп": getValue(options.startStopFunction)},
        {
          "Рулевые лепестки переключения передач":
              getValue(options.steeringWheelGearShiftPaddles)
        },
        {
          "Конфигурация рулевого управления 1":
              getValue(options.wheelConfiguration1)
        },
        {
          "Конфигурация рулевого управления 2":
              getValue(options.wheelConfiguration2)
        },
        {"Электроусилитель руля": getValue(options.servo)},
      ];

  List<Map<String, dynamic>> _climate() => [
        {"Климат-контроль 1 зона": getValue(options.climateControl1)},
        {"Климат-контроль 2 зоны": getValue(options.climateControl2)},
        {
          "Мультизонный климат-контроль":
              getValue(options.multizoneClimateControl)
        },
      ];

  List<Map<String, dynamic>> _lighting() => [
        {"Адаптивный свет": getValue(options.adaptiveLight)},
        {
          "Автоматическое управление светом":
              getValue(options.automaticLightingControl)
        },
        {"Дневные ходовые огни": getValue(options.drl)},
        {"Ассистент дальнего света": getValue(options.highBeamAssist)},
        {"Лазерные фары": getValue(options.laserLights)},
        {"Светодиодные фары": getValue(options.ledLights)},
        {"Омыватель фар": getValue(options.lightCleaner)},
        {"Датчик света": getValue(options.lightSensor)},
        {"Противотуманные фары": getValue(options.ptf)},
        {"Ксенон": getValue(options.xenon)},
      ];

  List<Map<String, dynamic>> _mirrors() => [
        {"Электрические зеркала": getValue(options.electroMirrors)},
        {"Автоматические зеркала": getValue(options.autoMirrors)},
        {"Задняя камера": getValue(options.rearCamera)},
        {"Камера 360": getValue(options.camera360)},
        {"Передняя камера": getValue(options.frontCamera)},
        {"Подогрев зеркал": getValue(options.mirrorsHeat)},
      ];

  List<Map<String, dynamic>> _roofAndWindow() => [
        {"Панорамная крыша": getValue(options.panoramaRoof)},
        {"Тонировка": getValue(options.tintedGlass)},
      ];

  List<Map<String, dynamic>> _materials() => [
        {"Алькантара": getValue(options.alcantara)},
        {"Эко кожа": getValue(options.ecoLeather)},
        {"Кожа": getValue(options.leather)},
        {"Кожаная ручка коробки передач": getValue(options.leatherGearStick)},
        {"Кожаный руль": getValue(options.steeringWheelGearShiftPaddles)},
      ];

  List<Map<String, dynamic>> _salon() => [
        {"Комбинированный салон": getValue(options.comboInterior)},
        {
          "Электрорегулировка водительского сиденья":
              getValue(options.driverSeatElectric)
        },
        {
          "Память положения водительского сиденья":
              getValue(options.driverSeatMemory)
        },
        {
          "Поддержка водительского сиденья": getValue(options.driverSeatSupport)
        },
        {
          "Регулировка высоты водительского сиденья":
              getValue(options.driverSeatUpdown)
        },
        {
          "Электрорегулировка пассажирского сиденья":
              getValue(options.passengerSeatElectric)
        },
        {
          "Регулировка высоты пассажирского сиденья":
              getValue(options.passengerSeatUpdown)
        },
        {"Поддержка передних сидений": getValue(options.frontSeatSupport)},
        {"Вентиляция задних сидений": getValue(options.rearSeatHeatVent)},
        {"Память положения задних сидений": getValue(options.rearSeatMemory)},
        {"Подогрев задних сидений": getValue(options.rearSeatsHeat)},
        {"Третий подголовник сзади": getValue(options.thirdRearHeadrest)},
        {"Третий ряд сидений": getValue(options.thirdRowSeats)},
      ];

  List<Map<String, dynamic>> _internalCharacteristics() => [
        {"Подсветка салона": getValue(options.decorativeInteriorLighting)},
        {"Накладки на пороги": getValue(options.doorSillPanel)},
        {
          "Подлокотник передний центральный":
              getValue(options.frontCentreArmrest)
        },
        {
          "Складывающееся пассажирское сиденье":
              getValue(options.foldingFrontPassengerSeat)
        },
        {"Складывающиеся столики сзади": getValue(options.foldingTablesRear)},
        {"Шторка заднего окна": getValue(options.rollerBlindForRearWindow)},
        {
          "Шторки на задние боковые окна":
              getValue(options.rollerBlindsForRearSideWindows)
        },
        {"Память положения сидений": getValue(options.seatMemory)},
        {"Трансформация сидений": getValue(options.seatTransformation)},
        {"Спортивные педали": getValue(options.sportPedals)},
        {"Спортивные сиденья": getValue(options.sportSeats)},
        {"Чёрный потолок": getValue(options.blackRoof)},
        {"Люк": getValue(options.hatch)},
      ];

  String getValue(bool value) => value ? "✅" : "❌";
// эко кожа
// кожа
// кожаная ручка коробки передач
// кожаный руль
}
