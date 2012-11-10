//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.vigilance
{
	import org.swiftsuspenders.errors.InjectorError;
	import org.swiftsuspenders.mapping.MappingEvent;
	import robotlegs.bender.extensions.logging.impl.LogMessageParser;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.ILogTarget;
	import robotlegs.bender.framework.api.LogLevel;

	public class VigilanceExtension implements IExtension, ILogTarget
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _messageParser:LogMessageParser = new LogMessageParser();

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function extend(context:IContext):void
		{
			context.addLogTarget(this);
			context.injector.addEventListener(MappingEvent.MAPPING_OVERRIDE, mappingOverrideHandler)
		}

		public function log(source:Object, level:uint, timestamp:int, message:String, params:Array = null):void
		{
			if (level <= LogLevel.WARN)
			{
				throw new Error(_messageParser.parseMessage(message, params));
			}
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		private function mappingOverrideHandler(event:MappingEvent):void
		{
			throw new InjectorError("Injector mapping override for type " +
					event.mappedType + " with name " + event.mappedName);
		}
	}
}
